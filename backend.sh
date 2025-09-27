#!/bin/bash

USERID=$(id -u)
TIMESTAMP=$(date +%F-%H-%M-%S)
SCRIPT_NAME=$( echo $0 | cut -d "." -f1)
LOGFILE=/tmp/$SCRIPT_NAME-$TIMESTAMP.log

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

if [ $USERID -ne 0 ]
  then 
      echo "please run the script as root user"
      exit 1
   else
      echo "you are super user"
fi

VALIDATE(){

   if [ $1 -ne 0 ]
     then 
         echo -e "$2....$R failure $N"
         exit 1
     else  
         echo -e "$2....$G success $N"
   fi     
}

dnf module disable nodejs -y &>>LOGFILE
VALIDATE $? "Disabling default nodejs"

dnf module enable nodejs:20 -y &>>LOGFILE
VALIDATE $? "enabling default nodejs :: 20 version"

dnf install nodejs -y &>>LOGFILE
VALIDATE $? "Installing nodejs"

useradd expense
VALIDATE $? "Creating expense user"











