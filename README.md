# Python App for project1

## Here is the application code that you can use for project1.  This is a very basic flask app for python, feel free to add more to the website if you know how. 

## To run the app, you will need to dockerize this application and push it to your dockerhub app

### Step 1. download this repo to your local machine `https://github.com/bdgomey/Azure104Project1.git` and cd into that directory

### Step 2. create a dockerhub account at dockerhub.com

### Step 3. Add your mysql connection string to the app.py file.  There will be 3 places to put this information the first one in the code will not have a database entry, please keep the connection string in the code as it is.

```python
db = mysql.connector.connect(
    host="",
    user="",
    passwd="",
    database="to_do_list"
)
```

### Step 4. create a docker image of this application and push it to your dockerhub account

```bash
docker login -u <your dockerhub username>
# enter your password
docker build -t <your dockerhub username>/<appName> .
docker push <your dockerhub username>/<appName>
```
make sure to use your dockerhub username you had when you created the dockerhub account. 

### Step 5. create a new web app in azure and make sure that it uses the container image you just created.  You will need to create a new app service plan.  You need to make sure that the service plan you use can have vnet integration enabled (free tier does not allow this)