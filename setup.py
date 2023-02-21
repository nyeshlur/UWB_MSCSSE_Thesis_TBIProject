from setuptools import setup

setup(
    name='TBI Diagnosis',
    version='1.0',
    description='Diagnosis of TBI using Pulsatility Ultrasound',
    packages=['src'],
    install_requires=[
        'numpy',
        'h5py',
        'tensorflow',
        'tensorboard',
        'Jupyter',
        'keras',
        'matplotlib',
        'opencv-python',
        'scikit-learn',
        'scipy'
    ]
)