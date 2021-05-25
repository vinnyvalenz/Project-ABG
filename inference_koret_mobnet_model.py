#!/scratch/cq73/.conda/envs/tfgpu/bin/ python3.7
# coding: utf-8

import matplotlib

matplotlib.use('Agg')  # Cam Bodine's genius solution to output plots!!
matplotlib.rcParams['figure.dpi'] = 72  # dpi manually set to match Shree's machine

import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
# import librosa
import IPython.display as ipd
# import librosa.display
import os
os.environ["CUDA_VISIBLE_DEVICES"] = "-1"
import joblib
import glob
import time
from datetime import date
# '''
# %env CUDA_DEVICE_ORDER=PCI_BUS_ID
# %env CUDA_VISIBLE_DEVICES=1
# '''
import tensorflow as tf
import IPython.display as display
from PIL import Image
import pathlib
import sys

AUTOTUNE = tf.data.experimental.AUTOTUNE
tf.__version__

# User inputs
os.chdir('C:/Users/tonys/OneDrive/Documents/School/Koret/Model/')
parent_dir = 'C:/Users/tonys/OneDrive/Documents/School/Koret/Data/'  # directory that contains sub-directories which each contain melspecs
out_dir = 'C:/Users/tonys/OneDrive/Documents/School/Koret/Results/'  # directory where pkl (or csv) file is written - one file per sub dir from parent_dir (above) E.g. Anthro.pkl where each ROW is a melspec
model_path = 'C:/Users/tonys/OneDrive/Documents/School/Koret/Model/xc_model_2021_.pb'  # where does the model live
logs_path = 'C:/Users/tonys/Documents/SchoolWork/Koret'  # some dir where you'd like error files written



print("Data dir = ", parent_dir)
print("Results dir = ", out_dir)
print("CNN checkpoint =", model_path)
print("Error logs will print to :", logs_path)

# input mfcc dependent on slurm array
# ABGO_dirs = os.listdir(parent_dir) # ABGO dirs (4 long)
ABGO_dirs = ['C:/Users/tonys/OneDrive/Documents/School/Koret/Data/anthro/',
             'C:/Users/tonys/OneDrive/Documents/School/Koret/Data/bio/',
             'C:/Users/tonys/OneDrive/Documents/School/Koret/Data/geo/',
             'C:/Users/tonys/OneDrive/Documents/School/Koret/Data/other/']

print("\nLoaded audio file dirs...")
print("Length of audio file list:", len(ABGO_dirs))


# FUNCTIONS
# function that interpretes image after being provided a path in process_path
def decode_img(img, IMG_HEIGHT, IMG_WIDTH):
    # convert the compressed string to a 3D uint8 tensor
    img = tf.image.decode_jpeg(img, channels=3)
    # Use `convert_image_dtype` to convert to floats in the [0,1] range.
    img = tf.image.convert_image_dtype(img, tf.float32)
    # resize the image to the desired size.
    return tf.image.resize(img, [IMG_HEIGHT, IMG_WIDTH])


# function to read in a file path
def process_path(file_path, IMG_HEIGHT, IMG_WIDTH):
    # load the raw data from the file as a string
    img = tf.io.read_file(file_path)
    img = decode_img(img, IMG_HEIGHT, IMG_WIDTH)
    return img  # , label


# In[4]:
# Load in model (not checkpoint)
model = tf.keras.models.load_model(model_path)
IMG_HEIGHT = 224
IMG_WIDTH = 224

model.summary()

print('Number of folders in the parent Mel-Spec directory:', len(ABGO_dirs))

start_time = time.time()

# iterate through each folder/wav file which contains mfccs (sub-dirs in parent_dir)
for i in range(len(ABGO_dirs)):
    try:
        temp_wav = ABGO_dirs[i]
        out_path_temp = os.path.join(out_dir, temp_wav + '.csv')
        print(temp_wav)

        if os.path.isfile(out_path_temp):
            print("WAV ALREADY PREDICTED")
            continue
        else:
            mel_store = os.path.join(parent_dir, temp_wav)
            print(mel_store)

            mel_store_lst = os.listdir(mel_store)  # temp dir with the PNGs
            loop_run = len(mel_store_lst)
            print("Number of mfccs in current dir =", loop_run)

            sigmoid_pred_lst = []
            mfcc_names = []
            size = (224, 224)
            softmax_pred_lst = []
            # iterate throuh each melspec in current sub directory

            for filename in os.listdir(ABGO_dirs[i]):
                if filename.endswith('.png'):
                    mfcc_names.append(filename)
                    print(filename)
                    img_ = process_path(os.path.join(mel_store, filename), IMG_HEIGHT=224, IMG_WIDTH=224)
                    img_ = tf.reshape(img_, shape=(1, IMG_HEIGHT, IMG_WIDTH, 3))

                    # get predictions
                    pred = model.predict(img_, verbose=0, steps=1, callbacks=None, max_queue_size=10,
                                         # made verbose = 0  here
                                         workers=1, use_multiprocessing=False)

                    sigmoid_pred = tf.math.sigmoid(pred).numpy()  # sigmoid here
                    print(sigmoid_pred)
                    sigmoid_pred_lst.append(sigmoid_pred)

                    #softmax_pred = tf.math.softmax(pred).numpy()  # softmax here
                    #softmax_pred_lst.append(softmax_pred)
                    #print(softmax_pred)

                    """
                for j in range(loop_run):
                fname = str(j) + '.png'
                mfcc_names.append(fname)

                img_ = process_path(os.path.join(mel_store, fname), IMG_HEIGHT=224, IMG_WIDTH=224)
                img_ = tf.reshape(img_, shape=(1, IMG_HEIGHT, IMG_WIDTH, 3))

                # get predictions
                pred = model.predict(img_, verbose=0, steps=1, callbacks=None, max_queue_size=10,
                                     # made verbose = 0  here
                                     workers=1, use_multiprocessing=False)

                sigmoid_pred = tf.math.sigmoid(pred).numpy()  # sigmoid here
                sigmoid_pred_lst.append(sigmoid_pred)
                
                """



            # format predictions
            #flat_sigmoid = [item for sublist in sigmoid_pred_lst for item in sublist]
            flat_sigmoid = [item for sublist in sigmoid_pred_lst for item in sublist]
            df_sigmoid = pd.DataFrame(flat_sigmoid)
            df_sigmoid = pd.concat([pd.Series(mfcc_names), df_sigmoid], axis=1,)
            df_sigmoid.columns = ["mfcc", "Anthro", "Bio", "Geo", "Other"]

            # save predictions
            df_sigmoid.to_csv(out_path_temp, index=False)
            print('Saved this file at:', out_path_temp, "Length was:", len(sigmoid_pred_lst))

    except Exception as e:
        print(e)
       # f = logs_path + temp_wav + '.txt'
        #f = open(f, 'w')
        #f.write('This wav file did not complete -%s' % e)
       # f.close()

    print('-' * 80)
    print()
print("--- %s seconds ---" % (time.time() - start_time))

today = date.today()
print("Today's date:", today)
