
# coding: utf-8

# import all packages here

# In[1]:


import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
get_ipython().magic(u'matplotlib inline')


# load the titanic3.csv

# In[2]:


tic = pd.read_csv('titanic3.csv')

tic.head(5)


# look at the info

# In[3]:


tic.info()


# convert data types of required columns

# In[4]:


tic.survived = tic.survived.astype('category')
tic.sex = tic.sex.astype('category')
tic.pclass = tic.pclass.astype('category')
tic.embarked = tic.embarked.astype('category')


# look for missing values

# In[5]:


tic.isnull().sum()


# drop columns not relevant 

# In[6]:


tic.drop(['home.dest', 'body', 'boat', 'cabin'], axis = 1, inplace = True)

tic.head(4)


# look for missing values and replace them

# drop missing in pclass

# In[7]:


tic.pclass.value_counts(dropna = False)


# In[8]:


tic[tic['pclass'].isnull()]


# In[9]:


tic[1309:]


# In[10]:


tic.drop(tic.index[1309:], inplace = True)
tic.tail(4)


# replace missing in age and fare

# In[11]:


# age has too many missing values, replace with mean
print(tic.age.mean())

tic.age = tic.age.fillna(tic.age.mean())


# In[12]:


# same for fare
tic.fare = tic.fare.fillna(tic.fare.mean())


# Replace missing values in embarked with most popular

# In[13]:


tic.embarked.value_counts(dropna = False)


# In[14]:


tic.embarked = tic.embarked.fillna('S')


# In[15]:


tic.isnull().sum()


# Extract the titles from name and store in title column

# In[16]:


tic['title'] = tic.name.str.extract('([A-Za-z]+)\.', expand = False)


# In[17]:


tic.head()


# In[18]:


pd.crosstab(tic.title, tic.sex)#, rownames = ['x'], colnames = ['y'])


# Look for the female doctor

# In[19]:


#tic[tic['title'] == 'Dr' & tic['sex'] == 'female']

tic[np.logical_and(tic.title == 'Dr', tic.sex == 'female')]


# Create “gender_name” variable

# In[47]:


tic['gender_name'] = tic['title'].replace(['Capt', 'Col', 'Don', 'Dr',
        'Jonkheer', 'Major', 'Mr', 'Rev', 'Sir'], 'Mr', regex = True)

tic['gender_name'] = tic['gender_name'].replace(['Dona', 'Lady', 'Mme', 'Mrs', 'Countess'], 'Mrs', regex = True)

tic['gender_name'] = tic['gender_name'].replace(['Miss', 'Mlle', 'Ms'], 'Miss', regex = True)

tic['gender_name'] = tic['gender_name'].replace('Master', 'Mast', regex = True)


# In[46]:


#def replace_all(text, dic):
 #   for i, j in dic.iteritems():
   #     text = text.replace(i, j)
  #  return text


# Change female doctor to Mrs

# In[53]:


tic.gender_name[181] = 'Mrs'


# In[55]:


pd.crosstab(tic.sex, tic.gender_name)


# Convert gender name to factor

# In[56]:


tic.gender_name = tic.gender_name.astype('category')


# Are those who pay less than the average for a ticket less likely to survive? Mean fare for each pclass

# In[61]:


class1 = tic[tic.pclass == 1]
class2 = tic[tic.pclass == 2]
class3 = tic[tic.pclass == 3]


# In[68]:


fare1 = class1.fare.mean()
fare2 = class2.fare.mean()
fare3 = class3.fare.mean()


# In[71]:


print(fare1, fare2, fare3)


# #Create fare_avg column

# In[ ]:


tic.fare_avg = tic.pclass


# In[130]:


tic.fare_avg = tic.fare_avg.astype(float)


# In[141]:


tic.fare_avg[tic.fare_avg == 1] = fare1
tic.fare_avg[tic.fare_avg == 2] = fare2
tic.fare_avg[tic.fare_avg == 3] = fare3


# In[144]:


tic.fare_avg.value_counts()


# Create fare-distance metric for titanic fare-distance = fare - mean(fare of pclass)

# In[136]:


tic['fare_distance'] = tic.fare - tic.fare_avg


# Add family column

# In[97]:


tic['family'] = np.nan

