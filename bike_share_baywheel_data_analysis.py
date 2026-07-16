# This Python 3 environment comes with many helpful analytics libraries installed
# It is defined by the kaggle/python Docker image: https://github.com/kaggle/docker-python
# For example, here's several helpful packages to load

import numpy as np # linear algebra
import pandas as pd # data processing, CSV file I/O (e.g. pd.read_csv)

# Input data files are available in the read-only "../input/" directory
# For example, running this (by clicking run or pressing Shift+Enter) will list all files under the input directory

import os
for dirname, _, filenames in os.walk('/kaggle/input'):
    for filename in filenames:
        print(os.path.join(dirname, filename))

# You can write up to 20GB to the current directory (/kaggle/working/) that gets preserved as output when you create a version using "Save & Run All" 
# You can also write temporary files to /kaggle/temp/, but they won't be saved outside of the current session

# Use the kagglehub client library to attach Kaggle resources like competitions, datasets, and models to your session
# Learn more about kagglehub: https://github.com/Kaggle/kagglehub/blob/main/README.md

import kagglehub
# kagglehub.dataset_download('<owner>/<dataset-slug>')


import pandas as pd
import matplotlib as plt 
import seaborn as sns 
import numpy as np

# import 
Bikedf = pd.read_csv ('/kaggle/input/datasets/thulilylamm/baywheel-lyft-dataset/combined_baywheels_2023_2026.csv')

print("Exploring Lyft Bikeshare dataset:")

print("Head of bikeshare dataset")
Bikedf.head()

print("Last 10 rows of the dataset")
Bikedf.tail()
### Many Nulls 
### end_station_id and end_station_name have many null values. This could mean that user often forget to return their bike to these station or these stations often run out of lock to 
### return bike 

## Display the structure of the dataset 
print("Data information:")
Bikedf.info()

##Summary Statistics of this dataset 
print("Summary statistics :")
Bikedf.describe()
