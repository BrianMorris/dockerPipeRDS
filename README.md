# Piping to RDS with Docker
code for using a docker container on AWS Fargate to pipe RDS databases.

## config
**Our bash script has default Source and Destination values set for: database user, password, host, database name
Any of these values can be overriden when configuring the task to run in AWS Fargate (See step 4 of Part 2).**

**By Default we are writing to an existing database, to create a new database as part of our process see the Extras section**
Here are the steps to take after cloning the github Repo:

### Part 1: Build image and push to docker hub
1) cd to cloned folder and use docker file to create a docker image with command: 

```docker build -t imagename .```

2) rename .env.sh.config file to .env.sh and populate with default username and password, and configure default host and db name in pipe.sh file 

3) tag docker image to prepare for pushing:

```docker tag imagename userRepo/imagename```

4) Push image to Docker hub:

```docker push userRepo/imagename```

### Part 2: Create and Run Task in AWS Elastic Container Service > Fargate
1) Navigate to AWS ECS management panel: (something like https://console.aws.amazon.com/ecs/home)

2) select task definitions from panel on left-hand side and click > create new task definition

3) select Fargate and minor details. Select Add container. enter the name of the image you pushed to docker hub: userRepo/imagename
and create task

4) navigate to task and select run task. make sure you edit the security groups to allow access to port 3306. In addition, under advanced options select add environment Variable. Here you can override the default values for any of our variables in pipe.sh. 
Use names: 
DB_USER_SRC,
DB_PWD_SRC,
DB_NAME_SRC,
DB_HOST_SRC
as keys. and if you want to change the destination variables, subsitute SRC with DEST. e.g.(DB_PWD_DEST)

5) now run the task to start piping into our new database, and view details in the log. Upon completing the pipe, the log will say done.

**Once we have a task defined in AWS ECS, we only need to perform steps 3-5 in Part 2.**

In the case we want to edit our image, after we rebuild and push to docker hub we only need select revise task under task definition and reload the new image to our task definition.(Part 2: step 3)


### Extra
If you want to create a new database on the host as part of your process set this env variable in Part 2 step 4:

```key: CREATE_DATABASE```
```value: true```

the database created will be the one set by the variable DB_NAME_DEST
