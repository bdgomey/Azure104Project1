# Python App for project1

## Here is the application code that you can use for project1.  This is a very basic flask app for python, feel free to add more to the website if you know how. 

## To run the app, you will need to dockerize this application and push it to your dockerhub app

### Step 1. download this repo to your local machine `https://github.com/bdgomey/Azure104Project1.git`

### Step 2. create a dockerhub account at dockerhub.com

### Step 3. Add your mysql connection string to the app.py file

```python
app.config['MYSQL_HOST'] = '<your mysql server name>'
app.config['MYSQL_USER'] = '<your mysql username>'
app.config['MYSQL_PASSWORD'] = '<your mysql password>'
app.config['MYSQL_DB'] = '<your mysql database name>'
```


### Step 3. create a docker image of this application and push it to your dockerhub account

```bash
docker login -u <your dockerhub username>
# enter your password
docker build -t <your dockerhub username>/<appName> .
docker push <your dockerhub username>/<appName>
```
