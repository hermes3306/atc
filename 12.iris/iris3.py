import pandas as pd
from sklearn import datasets
from sklearn.model_selection import train_test_split
from sklearn.ensemble import RandomForestClassifier
from sklearn import metrics

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

	x = data[['sepal length', 'sepal width', 'petal length', 'petal width']]
	y = data['species']

	x_train, x_test, y_train, y_test = train_test_split(x,y,test_size=0.3)
	print(len(x_train))
	print(len(x_test))
	print(len(y_train))
	print(len(y_test))

	forest = RandomForestClassifier(n_estimators=100)
	forest.fit(x_train, y_train)

	y_pred = forest.predict(x_test)
	print(y_pred)
	print(list(y_test))

	print('Correct rate:', metrics.accuracy_score(y_test,y_pred))
	

