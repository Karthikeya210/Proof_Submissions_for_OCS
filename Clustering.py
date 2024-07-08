import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

def preprocess_coordinates(coord):
    try:
        return float(''.join(filter(lambda x: x.isdigit() or x == '.', str(coord))))
    except ValueError:
        return np.nan

data = pd.read_csv('data/clustering_data.csv', dtype={'Pincode': str})

data['Latitude'] = data['Latitude'].apply(preprocess_coordinates)
data['Longitude'] = data['Longitude'].apply(preprocess_coordinates)

hs = 'TAMIL NADU'
filtered_data = data[data['StateName'] == hs]

if 'Pincode' not in filtered_data.columns or 'Latitude' not in filtered_data.columns or 'Longitude' not in filtered_data.columns:
    raise ValueError("The dataset does not contain required columns: 'Pincode', 'Latitude', 'Longitude'")

plt.scatter(filtered_data['Longitude'], filtered_data['Latitude'], c='blue', marker='o', s=50)
plt.title(f'Geographical Distribution of Pincodes in {hs}')
plt.xlabel('Longitude')
plt.ylabel('Latitude')
plt.grid()
plt.show()

filtered_data = filtered_data.dropna(subset=['Latitude', 'Longitude']) 
filtered_data = filtered_data.drop_duplicates(subset=['Pincode']) 

x = filtered_data[['Longitude', 'Latitude']].values
N = x.shape[0]
k = 3  
iterations = 150  

k_points = np.linspace(np.min(x, axis=0), np.max(x, axis=0), k)
k_points = np.sort(k_points, axis=0)

y = np.zeros(N)
X = np.hstack((x, y.reshape(-1, 1)))

for iter in range(iterations):
    labelch = False
    meanch = False
    
    for i in range(N):
        old_label = X[i, 2]
        new_label = old_label
        dist = float('inf')
        
        for j in range(k):
            dist1 = np.sum((X[i, :2] - k_points[j])**2)
            if dist1 < dist:
                new_label = j + 1
                dist = dist1
        
        X[i, 2] = new_label
        if new_label != old_label:
            labelch = True
    
    for i in range(k):
        points = X[X[:, 2] == i + 1, :2]
        if points.size:
            new_mean = np.mean(points, axis=0)
            if not np.allclose(new_mean, k_points[i]):
                k_points[i] = new_mean
                meanch = True
    
    if not labelch and not meanch:
        print("Converged on Iteration", iter)
        break

colors = ['r', 'g', 'b', 'y', 'c', 'm', 'k']
for i in range(k):
    cluster_points = X[X[:, 2] == i + 1]
    plt.scatter(cluster_points[:, 0], cluster_points[:, 1], c=colors[i], label=f'Cluster {i + 1}', s=50)
plt.scatter(k_points[:, 0], k_points[:, 1], c='black', marker='x', s=100, label='Centroids')
plt.title(f'K-means Clustering of Pincodes in {hs}')
plt.xlabel('Longitude')
plt.ylabel('Latitude')
plt.legend()
plt.grid()
plt.show()

for i in range(k):
    cluster_points = X[X[:, 2] == i + 1]
    print(f'Cluster {i + 1}:')
    print(f'Centroid: {k_points[i]}')
    print(f'Number of points: {cluster_points.shape[0]}')
    print('---')


