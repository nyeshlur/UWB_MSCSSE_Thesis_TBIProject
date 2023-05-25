function max_min_auto()
    folders = dir("/Users/nayanayeshlur/Downloads/New_Healthy_Representative_Displacement_Condensed_STDEV/");
    max_min = zeros(2, 1);
    for i = 1:length(folders)
        folder = folders(i).name;
        if folder ~= "." & folder ~= ".." & folder ~= ".DS_Store"
            fullName = strcat("/Users/nayanayeshlur/Downloads/New_Healthy_Representative_Displacement_Condensed_STDEV/",folder);
            max_min_vec = readFileswithinFolder(fullName);
            max_min = [max_min max_min_vec];
        end
    end
      max_min(:, 1) = [];
    save("Max_Min_Vector_H.mat", "max_min");
end

function max_min = readFileswithinFolder(folderName)
    Files = dir(folderName);
    max_min = zeros(2, 4);
    max_min_index = 1;
    for j=1:length(Files)
        FileNames = Files(j).name;
        [~, fName, fExt] = fileparts(FileNames);
        if fExt == ".mat"
            FileNames = strcat(strcat(folderName,"/"),strcat(FileNames,"/"));
            disp(FileNames);
            load(FileNames, "single_cycle");
            [~, idx] = max(single_cycle);
            max_min(1, max_min_index) = idx;
            [~, idx] = min(single_cycle);
            max_min(2, max_min_index) = idx;
            max_min_index = max_min_index + 1;
        end
    end
end