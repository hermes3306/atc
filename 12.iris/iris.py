import pandas as pd
from sklearn import datasets

if __name__ == '__main__':
	iris = datasets.load_iris()
	print('Iris targets:', iris.target_names)
	print('target" [0:sentosa, 1:versicolor, 2:virginica]')
	print('# of Data:' , len(iris.data))
	print('Column names:', iris.feature_names)  

	data = pd.DataFrame(
		{
			'sepal length': iris.data[:,0],
			'sepal width' : iris.data[:,1],
			'petal length': iris.data[:,2],
			'petal width' : iris.data[:,3],
			'species' : iris.target
		}
	)
	print(data.head())

