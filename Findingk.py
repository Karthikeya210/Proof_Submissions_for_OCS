import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

def ppc(coord):
    try:
        return float(''.join(filter(lambda x: x.isdigit() or x == '.', str(coord))))
    except ValueError:
        return np.nan

data = pd.read_csv('data/clustering_data.csv', dtype={'Pincode': str})

data['Latitude'] = data['Latitude'].apply(ppc)
data['Longitude'] = data['Longitude'].apply(ppc)

home_state = 'TAMIL NADU'
filtered_data = data[data['StateName'] == home_state]

if 'Pincode' not in filtered_data.columns or 'Latitude' not in filtered_data.columns or 'Longitude' not in filtered_data.columns:
    raise ValueError("The dataset does not contain required columns: 'Pincode', 'Latitude', 'Longitude'")

plt.scatter(filtered_data['Longitude'], filtered_data['Latitude'], c='blue', marker='o', s=50)
plt.title(f'Geographical Distribution of Pincodes in {home_state}')
plt.xlabel('Longitude')
plt.ylabel('Latitude')
plt.grid()
plt.show()

filtered_data = filtered_data.dropna(subset=['Latitude', 'Longitude'])
filtered_data = filtered_data.drop_duplicates(subset=['Pincode']) 

x = filtered_data[['Longitude', 'Latitude']].values

from sklearn.cluster import KMeans

inertia = []
k_range = range(1, 15)
for k in k_range:
    kmeans = KMeans(n_clusters=k, random_state=42)
    kmeans.fit(x)
    inertia.append(kmeans.inertia_)

plt.plot(k_range, inertia, marker='o')
plt.xlabel('Number of clusters')
plt.ylabel('Inertia')
plt.title('Elbow Method for Optimal k')
plt.grid()
plt.show()

