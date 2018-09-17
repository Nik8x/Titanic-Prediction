
import all packages here


```python
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
%matplotlib inline
```

load the titanic3.csv


```python
tic = pd.read_csv('titanic3.csv')

tic.head(5)
```




<div>
<style>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>pclass</th>
      <th>survived</th>
      <th>name</th>
      <th>sex</th>
      <th>age</th>
      <th>sibsp</th>
      <th>parch</th>
      <th>ticket</th>
      <th>fare</th>
      <th>cabin</th>
      <th>embarked</th>
      <th>boat</th>
      <th>body</th>
      <th>home.dest</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>1.0</td>
      <td>1.0</td>
      <td>Allen, Miss. Elisabeth Walton</td>
      <td>female</td>
      <td>29.0000</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>24160</td>
      <td>211.3375</td>
      <td>B5</td>
      <td>S</td>
      <td>2</td>
      <td>NaN</td>
      <td>St Louis, MO</td>
    </tr>
    <tr>
      <th>1</th>
      <td>1.0</td>
      <td>1.0</td>
      <td>Allison, Master. Hudson Trevor</td>
      <td>male</td>
      <td>0.9167</td>
      <td>1.0</td>
      <td>2.0</td>
      <td>113781</td>
      <td>151.5500</td>
      <td>C22 C26</td>
      <td>S</td>
      <td>11</td>
      <td>NaN</td>
      <td>Montreal, PQ / Chesterville, ON</td>
    </tr>
    <tr>
      <th>2</th>
      <td>1.0</td>
      <td>0.0</td>
      <td>Allison, Miss. Helen Loraine</td>
      <td>female</td>
      <td>2.0000</td>
      <td>1.0</td>
      <td>2.0</td>
      <td>113781</td>
      <td>151.5500</td>
      <td>C22 C26</td>
      <td>S</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>Montreal, PQ / Chesterville, ON</td>
    </tr>
    <tr>
      <th>3</th>
      <td>1.0</td>
      <td>0.0</td>
      <td>Allison, Mr. Hudson Joshua Creighton</td>
      <td>male</td>
      <td>30.0000</td>
      <td>1.0</td>
      <td>2.0</td>
      <td>113781</td>
      <td>151.5500</td>
      <td>C22 C26</td>
      <td>S</td>
      <td>NaN</td>
      <td>135.0</td>
      <td>Montreal, PQ / Chesterville, ON</td>
    </tr>
    <tr>
      <th>4</th>
      <td>1.0</td>
      <td>0.0</td>
      <td>Allison, Mrs. Hudson J C (Bessie Waldo Daniels)</td>
      <td>female</td>
      <td>25.0000</td>
      <td>1.0</td>
      <td>2.0</td>
      <td>113781</td>
      <td>151.5500</td>
      <td>C22 C26</td>
      <td>S</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>Montreal, PQ / Chesterville, ON</td>
    </tr>
  </tbody>
</table>
</div>



look at the info


```python
tic.info()
```

    <class 'pandas.core.frame.DataFrame'>
    RangeIndex: 1310 entries, 0 to 1309
    Data columns (total 14 columns):
    pclass       1309 non-null float64
    survived     1309 non-null float64
    name         1309 non-null object
    sex          1309 non-null object
    age          1046 non-null float64
    sibsp        1309 non-null float64
    parch        1309 non-null float64
    ticket       1309 non-null object
    fare         1308 non-null float64
    cabin        295 non-null object
    embarked     1307 non-null object
    boat         486 non-null object
    body         121 non-null float64
    home.dest    745 non-null object
    dtypes: float64(7), object(7)
    memory usage: 143.4+ KB


convert data types of required columns


```python
tic.survived = tic.survived.astype('category')
tic.sex = tic.sex.astype('category')
tic.pclass = tic.pclass.astype('category')
tic.embarked = tic.embarked.astype('category')
```

look for missing values


```python
tic.isnull().sum()
```




    pclass          1
    survived        1
    name            1
    sex             1
    age           264
    sibsp           1
    parch           1
    ticket          1
    fare            2
    cabin        1015
    embarked        3
    boat          824
    body         1189
    home.dest     565
    dtype: int64



drop columns not relevant 


```python
tic.drop(['home.dest', 'body', 'boat', 'cabin'], axis = 1, inplace = True)

tic.head(4)
```




<div>
<style>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>pclass</th>
      <th>survived</th>
      <th>name</th>
      <th>sex</th>
      <th>age</th>
      <th>sibsp</th>
      <th>parch</th>
      <th>ticket</th>
      <th>fare</th>
      <th>embarked</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>1.0</td>
      <td>1.0</td>
      <td>Allen, Miss. Elisabeth Walton</td>
      <td>female</td>
      <td>29.0000</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>24160</td>
      <td>211.3375</td>
      <td>S</td>
    </tr>
    <tr>
      <th>1</th>
      <td>1.0</td>
      <td>1.0</td>
      <td>Allison, Master. Hudson Trevor</td>
      <td>male</td>
      <td>0.9167</td>
      <td>1.0</td>
      <td>2.0</td>
      <td>113781</td>
      <td>151.5500</td>
      <td>S</td>
    </tr>
    <tr>
      <th>2</th>
      <td>1.0</td>
      <td>0.0</td>
      <td>Allison, Miss. Helen Loraine</td>
      <td>female</td>
      <td>2.0000</td>
      <td>1.0</td>
      <td>2.0</td>
      <td>113781</td>
      <td>151.5500</td>
      <td>S</td>
    </tr>
    <tr>
      <th>3</th>
      <td>1.0</td>
      <td>0.0</td>
      <td>Allison, Mr. Hudson Joshua Creighton</td>
      <td>male</td>
      <td>30.0000</td>
      <td>1.0</td>
      <td>2.0</td>
      <td>113781</td>
      <td>151.5500</td>
      <td>S</td>
    </tr>
  </tbody>
</table>
</div>



look for missing values and replace them

drop missing in pclass


```python
tic.pclass.value_counts(dropna = False)
```




     3.0    709
     1.0    323
     2.0    277
    NaN       1
    Name: pclass, dtype: int64




```python
tic[tic['pclass'].isnull()]
```




<div>
<style>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>pclass</th>
      <th>survived</th>
      <th>name</th>
      <th>sex</th>
      <th>age</th>
      <th>sibsp</th>
      <th>parch</th>
      <th>ticket</th>
      <th>fare</th>
      <th>embarked</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>1309</th>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
  </tbody>
</table>
</div>




```python
tic[1309:]
```




<div>
<style>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>pclass</th>
      <th>survived</th>
      <th>name</th>
      <th>sex</th>
      <th>age</th>
      <th>sibsp</th>
      <th>parch</th>
      <th>ticket</th>
      <th>fare</th>
      <th>embarked</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>1309</th>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
  </tbody>
</table>
</div>




```python
tic.drop(tic.index[1309:], inplace = True)
tic.tail(4)
```




<div>
<style>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>pclass</th>
      <th>survived</th>
      <th>name</th>
      <th>sex</th>
      <th>age</th>
      <th>sibsp</th>
      <th>parch</th>
      <th>ticket</th>
      <th>fare</th>
      <th>embarked</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>1305</th>
      <td>3.0</td>
      <td>0.0</td>
      <td>Zabour, Miss. Thamine</td>
      <td>female</td>
      <td>NaN</td>
      <td>1.0</td>
      <td>0.0</td>
      <td>2665</td>
      <td>14.4542</td>
      <td>C</td>
    </tr>
    <tr>
      <th>1306</th>
      <td>3.0</td>
      <td>0.0</td>
      <td>Zakarian, Mr. Mapriededer</td>
      <td>male</td>
      <td>26.5</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>2656</td>
      <td>7.2250</td>
      <td>C</td>
    </tr>
    <tr>
      <th>1307</th>
      <td>3.0</td>
      <td>0.0</td>
      <td>Zakarian, Mr. Ortin</td>
      <td>male</td>
      <td>27.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>2670</td>
      <td>7.2250</td>
      <td>C</td>
    </tr>
    <tr>
      <th>1308</th>
      <td>3.0</td>
      <td>0.0</td>
      <td>Zimmerman, Mr. Leo</td>
      <td>male</td>
      <td>29.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>315082</td>
      <td>7.8750</td>
      <td>S</td>
    </tr>
  </tbody>
</table>
</div>



replace missing in age and fare


```python
# age has too many missing values, replace with mean
print(tic.age.mean())

tic.age = tic.age.fillna(tic.age.mean())
```

    29.8811345124283



```python
# same for fare
tic.fare = tic.fare.fillna(tic.fare.mean())
```

Replace missing values in embarked with most popular


```python
tic.embarked.value_counts(dropna = False)
```




    S      914
    C      270
    Q      123
    NaN      2
    Name: embarked, dtype: int64




```python
tic.embarked = tic.embarked.fillna('S')
```


```python
tic.isnull().sum()
```




    pclass      0
    survived    0
    name        0
    sex         0
    age         0
    sibsp       0
    parch       0
    ticket      0
    fare        0
    embarked    0
    dtype: int64



Extract the titles from name and store in title column


```python
tic['title'] = tic.name.str.extract('([A-Za-z]+)\.', expand = False)
```


```python
tic.head()
```




<div>
<style>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>pclass</th>
      <th>survived</th>
      <th>name</th>
      <th>sex</th>
      <th>age</th>
      <th>sibsp</th>
      <th>parch</th>
      <th>ticket</th>
      <th>fare</th>
      <th>embarked</th>
      <th>title</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>1.0</td>
      <td>1.0</td>
      <td>Allen, Miss. Elisabeth Walton</td>
      <td>female</td>
      <td>29.0000</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>24160</td>
      <td>211.3375</td>
      <td>S</td>
      <td>Miss</td>
    </tr>
    <tr>
      <th>1</th>
      <td>1.0</td>
      <td>1.0</td>
      <td>Allison, Master. Hudson Trevor</td>
      <td>male</td>
      <td>0.9167</td>
      <td>1.0</td>
      <td>2.0</td>
      <td>113781</td>
      <td>151.5500</td>
      <td>S</td>
      <td>Master</td>
    </tr>
    <tr>
      <th>2</th>
      <td>1.0</td>
      <td>0.0</td>
      <td>Allison, Miss. Helen Loraine</td>
      <td>female</td>
      <td>2.0000</td>
      <td>1.0</td>
      <td>2.0</td>
      <td>113781</td>
      <td>151.5500</td>
      <td>S</td>
      <td>Miss</td>
    </tr>
    <tr>
      <th>3</th>
      <td>1.0</td>
      <td>0.0</td>
      <td>Allison, Mr. Hudson Joshua Creighton</td>
      <td>male</td>
      <td>30.0000</td>
      <td>1.0</td>
      <td>2.0</td>
      <td>113781</td>
      <td>151.5500</td>
      <td>S</td>
      <td>Mr</td>
    </tr>
    <tr>
      <th>4</th>
      <td>1.0</td>
      <td>0.0</td>
      <td>Allison, Mrs. Hudson J C (Bessie Waldo Daniels)</td>
      <td>female</td>
      <td>25.0000</td>
      <td>1.0</td>
      <td>2.0</td>
      <td>113781</td>
      <td>151.5500</td>
      <td>S</td>
      <td>Mrs</td>
    </tr>
  </tbody>
</table>
</div>




```python
pd.crosstab(tic.title, tic.sex)#, rownames = ['x'], colnames = ['y'])
```




<div>
<style>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th>sex</th>
      <th>female</th>
      <th>male</th>
    </tr>
    <tr>
      <th>title</th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>Capt</th>
      <td>0</td>
      <td>1</td>
    </tr>
    <tr>
      <th>Col</th>
      <td>0</td>
      <td>4</td>
    </tr>
    <tr>
      <th>Countess</th>
      <td>1</td>
      <td>0</td>
    </tr>
    <tr>
      <th>Don</th>
      <td>0</td>
      <td>1</td>
    </tr>
    <tr>
      <th>Dona</th>
      <td>1</td>
      <td>0</td>
    </tr>
    <tr>
      <th>Dr</th>
      <td>1</td>
      <td>7</td>
    </tr>
    <tr>
      <th>Jonkheer</th>
      <td>0</td>
      <td>1</td>
    </tr>
    <tr>
      <th>Lady</th>
      <td>1</td>
      <td>0</td>
    </tr>
    <tr>
      <th>Major</th>
      <td>0</td>
      <td>2</td>
    </tr>
    <tr>
      <th>Master</th>
      <td>0</td>
      <td>61</td>
    </tr>
    <tr>
      <th>Miss</th>
      <td>260</td>
      <td>0</td>
    </tr>
    <tr>
      <th>Mlle</th>
      <td>2</td>
      <td>0</td>
    </tr>
    <tr>
      <th>Mme</th>
      <td>1</td>
      <td>0</td>
    </tr>
    <tr>
      <th>Mr</th>
      <td>0</td>
      <td>757</td>
    </tr>
    <tr>
      <th>Mrs</th>
      <td>197</td>
      <td>0</td>
    </tr>
    <tr>
      <th>Ms</th>
      <td>2</td>
      <td>0</td>
    </tr>
    <tr>
      <th>Rev</th>
      <td>0</td>
      <td>8</td>
    </tr>
    <tr>
      <th>Sir</th>
      <td>0</td>
      <td>1</td>
    </tr>
  </tbody>
</table>
</div>



Look for the female doctor


```python
#tic[tic['title'] == 'Dr' & tic['sex'] == 'female']

tic[np.logical_and(tic.title == 'Dr', tic.sex == 'female')]
```




<div>
<style>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>pclass</th>
      <th>survived</th>
      <th>name</th>
      <th>sex</th>
      <th>age</th>
      <th>sibsp</th>
      <th>parch</th>
      <th>ticket</th>
      <th>fare</th>
      <th>embarked</th>
      <th>title</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>181</th>
      <td>1.0</td>
      <td>1.0</td>
      <td>Leader, Dr. Alice (Farnham)</td>
      <td>female</td>
      <td>49.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>17465</td>
      <td>25.9292</td>
      <td>S</td>
      <td>Dr</td>
    </tr>
  </tbody>
</table>
</div>



Create “gender_name” variable


```python
tic['gender_name'] = tic['title'].replace(['Capt', 'Col', 'Don', 'Dr',
        'Jonkheer', 'Major', 'Mr', 'Rev', 'Sir'], 'Mr', regex = True)

tic['gender_name'] = tic['gender_name'].replace(['Dona', 'Lady', 'Mme', 'Mrs', 'Countess'], 'Mrs', regex = True)

tic['gender_name'] = tic['gender_name'].replace(['Miss', 'Mlle', 'Ms'], 'Miss', regex = True)

tic['gender_name'] = tic['gender_name'].replace('Master', 'Mast', regex = True)
```


```python
#def replace_all(text, dic):
 #   for i, j in dic.iteritems():
   #     text = text.replace(i, j)
  #  return text
```

Change female doctor to Mrs


```python
tic.gender_name[181] = 'Mrs'
```

    C:\ProgramData\Anaconda3\lib\site-packages\ipykernel_launcher.py:1: SettingWithCopyWarning: 
    A value is trying to be set on a copy of a slice from a DataFrame
    
    See the caveats in the documentation: http://pandas.pydata.org/pandas-docs/stable/indexing.html#indexing-view-versus-copy
      """Entry point for launching an IPython kernel.



```python
pd.crosstab(tic.sex, tic.gender_name)
```




<div>
<style>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th>gender_name</th>
      <th>Mast</th>
      <th>Miss</th>
      <th>Mr</th>
      <th>Mrs</th>
    </tr>
    <tr>
      <th>sex</th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>female</th>
      <td>0</td>
      <td>264</td>
      <td>0</td>
      <td>202</td>
    </tr>
    <tr>
      <th>male</th>
      <td>61</td>
      <td>0</td>
      <td>782</td>
      <td>0</td>
    </tr>
  </tbody>
</table>
</div>



Convert gender name to factor


```python
tic.gender_name = tic.gender_name.astype('category')
```

Are those who pay less than the average for a ticket less likely to survive? Mean fare for each pclass


```python
class1 = tic[tic.pclass == 1]
class2 = tic[tic.pclass == 2]
class3 = tic[tic.pclass == 3]
```


```python
fare1 = class1.fare.mean()
fare2 = class2.fare.mean()
fare3 = class3.fare.mean()
```


```python
print(fare1, fare2, fare3)
```

    87.50899164086687 21.1791963898917 13.331086994755056


#Create fare_avg column


```python
tic.fare_avg = tic.pclass
```


```python
tic.fare_avg = tic.fare_avg.astype(float)
```


```python
tic.fare_avg[tic.fare_avg == 1] = fare1
tic.fare_avg[tic.fare_avg == 2] = fare2
tic.fare_avg[tic.fare_avg == 3] = fare3
```


```python
tic.fare_avg.value_counts()
```




    13.331087    709
    87.508992    323
    21.179196    277
    Name: pclass, dtype: int64



Create fare-distance metric for titanic fare-distance = fare - mean(fare of pclass)


```python
tic['fare_distance'] = tic.fare - tic.fare_avg
```

Add family column


```python
tic['family'] = np.nan
```
