# Piping to RDS with Docker
code for using a docker container on AWS Fargate to pipe RDS databases.


## config
Our bash script has default Source and Destination values set for: database user, password, host, database name


Any of these values can be overriden when configuring the task to run in AWS Fargate (See step 8).


Here is process from cloning github Repo:

1) cd to cloned folder and use docker file to create a docker image with command: 

```docker build -t imagename .```

2) rename .env.sh.config file to .env.sh and populate with default username and password, and configure default host and db name in pipe.sh file 

3) tag docker image to prepare for pushing:

```docker tag imagename userRepo/imagename```

4) Push image to Docker hub

```docker push userRepo/imagename```

5) Navigate to AWS ECS management panel: (something like https://console.aws.amazon.com/ecs/home)

6) select task definitions from panel on left-hand side and click > create new task definition

7) select Fargate and minor details. Select Add container. enter the name of the image you pushed to docker hub: userRepo/imagename
and create task

8) navigate to task and select run task. make sure you edit the security groups to allow access to port 3306. In addition, under advanced options select add environment Variable. Here you can override the default values for any of our variables in pipe.sh. 
Use names: 
DB_USER_SRC
DB_PWD_SRC
DB_NAME_SRC
DB_HOST_SRC
as keys. and if you want to change the destination variables, subsitute SRC with DEST. e.g.(DB_PWD_DEST)

9) select run task, and view details in the log.



