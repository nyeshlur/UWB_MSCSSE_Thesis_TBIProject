import config
import os
import numpy as np
import cv2
import math
import matplotlib.pyplot as plt
import sklearn
import h5py
from tensorflow.keras import backend as K
from scipy.io import loadmat
from multiprocessing import Process, Lock, Manager
from PIL import Image

old_bad_patients = [1, 14, 22, 23, 27, 28, 32, 34, 35, 36, 37, 38, 39, 44, 49, 69, 71, 
                78, 82, 90, 98, 101, 121, 124, 128, 133, 928]

IPH_patients = ['DoD008', 'DoD009', 'DoD010', 'DoD012', 'DoD022', 'DoD047', 'DoD053', 
                'DoD062', 'DoD066', 'DoD067', 'DoD069', 'DoD074', 'DoD075', 'DoD078', 
                'DoD085', 'DoD089', 'DoD093', 'DoD101', 'DoD105', 'DoD107', 'DoD110', 
                'DoD112', 'DoD113', 'DoD120', 'DoD121', 'DoD126', 'DoD129', 'DoD130', 
                'DoD133']

bad_patients = ['DoD027', 'DoD028', 'DoD035', 'DoD036', 'DoD038', 'DoD049', 'DoD069', 'DoD090']


def standardize(displacement, x_dim, y_dim):
    """
    Standardize displacement data
    Output values have a mean of 0 and std = 1
    Args:
        displacement (numpy array): one displacement frame
        x_dim (int): horizontal dim of the final image
        y_dim (int): vertical dim of the final image
    Return:
        displace_data (numpy array): normalized displacement shape (x_dim, y_dim)
    """
    displacement = cv2.resize(displacement, (y_dim, x_dim))
    
    # center around 0
    centered = displacement - displacement.mean()
    
    # divide by the standard deviation
    if np.std(centered) != 0:
        centered_scaled = centered / np.std(centered)
        
    displacement = centered_scaled
 
    return displacement


def extract_single_frame_from_raw_displacement(rawData, cardiac_cycle=1, frame=0):
    """
    Extract the displacement data from a patient file
    Choose one cardiac cycle and a single frame in this cardiac cycle
    
    Args:
        rawData (raw from .mat): raw data loaded from .mat file
        cardiac_cycle (int): number of the th cycle to extract data from
        frame (int): the th frame after the start of a cardiac cycle 
        
    Returns:
        displace_data (numpy array): displacement data (x_dim, y_dim, 1)
    """
    displacement = np.array(list(rawData['displacement']))
    hrTimes = np.array(list(rawData['hrTimes']))
    disShape = displacement.shape
    # extract data from the cardiac_cycle th cycle
    start = int(math.ceil(30 * hrTimes[0, cardiac_cycle]))
    displace_data = np.zeros([disShape[0], disShape[1], 1])
    # take the th displacement after the start of a cardiac cycle
    displace_data[:,:,0] = displacement[:, :, start + frame]
    
    return np.array(displace_data.astype('float64'))


def extract_single_frame_from_displacementNorm(rawData, cardiac_cycle=0, frame=9):
    """
    Extract the displacement data from displacementNorm dataset
    Choose one cardiac cycle and a single frame in this cardiac cycle
    displacementNorm has shape (x_dim, y_dim, 30, n_cycles)
    
    Args:
        rawData (raw from .mat): raw data loaded from .mat file
        cardiac_cycle (int): number of the th cycle to extract data from
        frame (int): the th frame after the start of a cardiac cycle 
        
    Returns:
        displace_data (numpy array): displacement data (x_dim, y_dim)
    """
    displacement = np.array(list(rawData['displacementNorm']))
    disShape = displacement.shape
    # extract data from the cardiac_cycle th cycle
    displace_data = np.zeros([disShape[0],disShape[1]])
    if (len(disShape) == 4):
        displace_data[:,:] = displacement[:, :, frame, cardiac_cycle]
    else:
        # handle cases where there is only one cycle
        displace_data[:,:] = displacement[:, :, frame]
                    
    return np.array(displace_data.astype('float64'))


def make_label(rawData, x_dim, y_dim, objective):
    """
    Make the label according to model's objective
    Objective = 0: find skull
    Objective = 1: find bleed
    Objective = 2: find brain
    Objective = 3: find ventricle
    
    Args:
        rarData: data read from loadmat()
        objective (int): find brain or fine bleed
        x_dim (int): horizontal dim of the final image
        y_dim (int): vertical dim of the final image
    
    Return:
        label (numpy.arr): the label (x_dim, y_dim)
    """
    # get label
    if objective == 0:
        # skull
        mask = np.array(list(rawData['skullMaskThick']))
    elif objective == 1:
        # bleed
        mask = np.array(list(rawData['bloodMaskThick']))
    elif objective == 2:
        mask = np.array(list(rawData['brainMask']))
    else:
        mask = np.array(list(rawData['ventMaskThick']))
    
    # resize the masks
    label = cv2.resize(mask, (y_dim, x_dim))
    
    return label.astype('float32')


def get_bMode(rawData, x_dim, y_dim):
    """
    Get the bMode image from raw data
    
    Args:
        rarData: data read from loadmat()
        x_dim (int): horizontal dim of the final image
        y_dim (int): vertical dim of the final image
        
    Returns:
        bMode (numpy.arr): bMode image (x_dim, y_dim)
    """
    # get the bmode from raw data
    bMode = np.array(list(rawData['bModeNorm']))
    
    # resize
    bMode = np.log10(bMode)
    bMode = bMode.astype('float64')
    
    # some bModeNorm data have dimensions (x_dim, y_dim)
    # those do not need to be processed in the if statement
    if len(bMode.shape) > 2:
        bMode = np.mean(bMode, axis=2)
        bMode = bMode[:, :, 0]
    bMode = cv2.resize(bMode, (y_dim, x_dim))
    
    return bMode


def process_one_file(filePath, x_dim, y_dim, objective):
    rawData = loadmat(filePath)

    # extract the displacement data
    #displace_data = extract_single_frame_from_raw_displacement(rawData)
    displace_data = extract_single_frame_from_displacementNorm(rawData)
    # standardize
    displace_data = standardize(displace_data, x_dim, y_dim)
    displace_data = displace_data.reshape([x_dim, y_dim, 1])
    
    # get bMode images
    bMode = get_bMode(rawData, x_dim, y_dim)
    
    # make label
    label = make_label(rawData, x_dim, y_dim, objective)

    return np.array(displace_data), np.array(bMode), np.array(label)


def process_one_patient(path, x_dim, y_dim, objective):
    """
    Process the raw data for a patient
    
    Args:
        path (str): path to the data file
        objective (int): the objective of processing (0 to find skull, 1 to find bleed)
        x_dim (int): horizontal dim of the final image
        y_dim (int): vertical dim of the final image
        
    Returns:
        displacement_list: displacement frames from a mat file (N, x_dim, y_dim, 1)
        label_list: labels (N, x_dim, y_dim, 1)
        bMode_list: corresponding bMode images (N, x_dim, y_dim, 1)
        fileNames: names of files where data come from (N,)
    """
    # list of displacement
    displacement_list = []
    # list of bMode
    bMode_list = []
    #list of labels
    label_list = []
    # list of file names
    fileNames = []
    # process all file in the directory
    for fileName in os.listdir(path):
        if ".mat" in fileName:
            filePath = os.path.join(path, fileName)
            displace_data, bMode, label = process_one_file(filePath, x_dim, y_dim, objective)

            displacement_list.append(displace_data)
            label_list.append(label)
            bMode_list.append(bMode)
            fileNames.append(fileName)
            
    return (np.array(displacement_list), 
            np.array(label_list), 
            np.array(bMode_list), 
            np.array(fileNames))


def process_all_patients(path, objective=1, x_dim=256, y_dim=80, patient_nums=None):
    """
    Process data of all patients
    Args:
        path (string): path to folder storing patient data
        objective (integer): 0-skull mask, 1-blood mask
        patient_nums (list(string)): list of patient numbers to process;
                                process all if None is given;
                                format: DoDxxx
        x_dim (int): horizontal dim of the final image
        y_dim (int): vertical dim of the final image
    Return:
        numpy array of displacement data, label, bMode, list of patient files
    """
    displacement_list = []
    label_list = []
    bMode_list = []
    file_list = []
    
    # process all if no patient number is given
    if patient_nums is None:
        patient_nums = [patient for patient in os.listdir(path) if patient not in bad_patients]
    
    for patient_num in patient_nums:
        if os.path.isdir(os.path.join(path, patient_num)):
            print("Process data for patient", patient_num)
            dataPath = os.path.join(path, patient_num)
            displacement, label, bMode, fileNames = process_one_patient(path=dataPath, 
                                                                   x_dim=x_dim, 
                                                                   y_dim=y_dim, 
                                                                   objective=objective)
            displacement_list.extend(displacement)
            label_list.extend(label)
            bMode_list.extend(bMode)
            file_list.extend(fileNames)
        else:
            print('Patient' + patient_num + 'does not exist')
    
    print("Processed", len(patient_nums), "patients")
    
    return np.array(displacement_list), np.array(label_list), np.array(bMode_list), np.array(file_list)


def multiprocess_all_patients(path, objective=1, x_dim=256, y_dim=80, patient_nums=None):
    """
    Process all the patient in parallel using 10 processes
    """ 
    manager = Manager()
    
    displacement_list = manager.list()
    label_list = manager.list()
    bMode_list = manager.list()
    file_list = manager.list()
    
    # inner function for multiprocessing
    def process_patient(lock, path, patient, x_dim, y_dim, objective):
        lock.acquire()
        print("Process data for patient", patient)
        lock.release()
        dataPath = os.path.join(path, patient)
        displacement, label, bMode, fileNames = process_one_patient(path=dataPath, 
                                                                       x_dim=x_dim, 
                                                                       y_dim=y_dim, 
                                                                       objective=objective)

        # lock the share resource and add data to common storage
        lock.acquire()
        displacement_list.extend(displacement)
        label_list.extend(label)
        bMode_list.extend(bMode)
        file_list.extend(fileNames)
        lock.release()
        # end of inner function
    
    # process all if no patient number is given
    if patient_nums is None:
        patient_nums = [patient for patient in os.listdir(path) if patient not in bad_patients]
    
    # total # of patient
    num_patients = len(patient_nums)
    # current index in the list of patients
    curr_idx = 0
    # number of threads spawned so far
    thread_num = 0
    # max num of threads
    max_num_threads = 5
    
    lock = Lock()
    while curr_idx < num_patients:
        processes = []
        while thread_num < max_num_threads and curr_idx < num_patients:
            p = Process(target=process_patient, args=(lock, 
                                                      path, 
                                                      patient_nums[curr_idx], 
                                                      x_dim, 
                                                      y_dim, 
                                                      objective))
            p.start()
            processes.append(p)
            curr_idx += 1
            thread_num += 1
        
        # reset the number of threads
        thread_num = 0
        # terminate the processes
        for process in processes:
            process.join()
    print("Processed", len(patient_nums), "patients")
    
    return np.array(displacement_list), np.array(label_list), np.array(bMode_list), np.array(file_list)


def make_hdf5(file_name, save_path, data_path):
    """
    Make hdf5 data file
    Pool all patient files before dividing into dev set and
    
    Args"
        file_name: name of hdf5
        save_path: path to saved file
        data_path: path to raw data
    """
    # process data
    displacement, label, bMode, fileNames = process_all_patients(data_path, objective=1, patient_nums=None)
    
    # change the dimensions of displacement
    # from (N, x_dim, y_dim, n_channel)
    # to (N, n_channel, x_dim, y_dim)
    #displacement = np.moveaxis(displacement, 3, 1)
    
    # remove the n_channel from label and bMode
    # from (N, x_dim, y_dim, n_channel = 1)
    # to (N, x_dim, y_dim)
    #label = np.squeeze(label, axis=3)
    #bMode = np.squeeze(bMode, axis=3)
    
    # create a hdf5 file
    f = h5py.File(os.path.join(save_path, file_name), 'w')
    
    training_group = f.create_group("training")
    testing_group = f.create_group('testing')
    
    # shuffle the dataset
    displacement, label, bMode, fileNames = sklearn.utils.shuffle(displacement, 
                                                                  label, 
                                                                  bMode, 
                                                                  fileNames, 
                                                                  random_state=0)
    
    num_examples = displacement.shape[0]
    # add data to the defined data buckets
    _add_dataset(training_group, 
                 displacement[0: int(0.8*num_examples)],
                 label[0: int(0.8*num_examples)],
                 bMode[0: int(0.8*num_examples)],
                 fileNames[0: int(0.8*num_examples)])
    _add_dataset(testing_group, 
                 displacement[int(0.8*num_examples):], 
                 label[int(0.8*num_examples):],
                 bMode[int(0.8*num_examples):],
                 fileNames[int(0.8*num_examples):])
    
    f.close()


def make_hdf5_by_patient_group(file_name, save_path, data_path, objective):
    """
    Make hdf5 data file
    Divide patients into dev set and test set before process
    Objective = 0: find skull
    Objective = 1: find bleed
    Objective = 2: find brain
    
    Args"
        file_name: name of hdf5
        save_path: path to saved file
        data_path: path to raw data
        objective (int): objective of the data
    """
    # divide patient into dev set and test set
    all_patients = [patient for patient in os.listdir(data_path) if patient not in bad_patients]
    all_patients = sklearn.utils.shuffle(all_patients, random_state=0)
    dev_patients = all_patients[0: int(0.9*len(all_patients))]
    test_patients = all_patients[int(0.9*len(all_patients)):]
                                       
    # process data
    print("Processing dev patients")
    dev_displacement, dev_label, dev_bMode, dev_fileNames = process_all_patients(data_path, 
                                                                                 objective=objective, 
                                                                                 patient_nums=dev_patients)
    
    print("Processing test patients")
    test_displacement, test_label, test_bMode, test_fileNames = process_all_patients(data_path, 
                                                                                 objective=objective, 
                                                                                 patient_nums=test_patients)
    
    # create a hdf5 file
    f = h5py.File(os.path.join(save_path, file_name), 'w')
    
    dev_group = f.create_group('dev')
    test_group = f.create_group('test')
    
    # add data to the defined data buckets
    _add_dataset(dev_group, 
                 dev_displacement,
                 dev_label,
                 dev_bMode,
                 dev_fileNames)
    _add_dataset(test_group, 
                 test_displacement, 
                 test_label,
                 test_bMode,
                 test_fileNames)
    
    f.close()


def _add_dataset(group: h5py.Group, displacement, label, bMode, fileNames):
    """
    Add a dataset to h5py group
    The saved data have shapes:
        x (N, nchannel, 256, 80)
        y (N, n_class, 256, 80)
        bMode (N, 256, 80)
        names (N, 1)
    
    @param: group: h5py group
    @param: displacement: displacement data (N, n_channel, x_dim, y_dim)
    @param: label: label (N, n_class, x_dim, y_dim)
    @param: bMode: bMode ultrasound (N, x_dim, y_dim)
    @param: fileNames: file names of the displacement data (N,)
    """
    # convert the label to a ASCII format for h5py
    asciiList = [name.encode("ascii", "ignore") for name in fileNames]
    
    x = group.create_dataset('x', data=displacement)
    y = group.create_dataset('y', data=label)
    bMode = group.create_dataset('bMode', data=bMode)
    filename = group.create_dataset('filename', data=asciiList)


if __name__ == '__main__':
    # objective:
    #   mode 0 = skull
    #   mode 1 = blood
    #   mode 2 = brain
    #   mode 3 = ventricle
    mode = config.DATA_MODE
    if mode == 0:
        objective = 'skull'
    elif mode == 1:
        objective = 'blood'
    elif mode == 2:
        objective = 'brain'
    elif mode == 3:
        objective = 'vent'
    else:
        raise ValueError("Enter a valid mode")

    make_hdf5_by_patient_group(objective + '_displacementNorm_data.hdf5', 
                           config.PROCESSED_DATA_DIR, 
                           config.RAW_DATA_DIR,
                           objective=mode)