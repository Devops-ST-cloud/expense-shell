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

dnf install mysql-server -y &>>$LOGFILE
VALIDATE $? "Installing MySql Server"

systemctl enable mysqld &>>$LOGFILE
VALIDATE $? "Enabling MySql Server"

systemctl start mysqld &>>$LOGFILE
VALIDATE $? "starting MySql Server"

mysql_secure_installation --set-root-pass ExpenseApp@1 &>>$LOGFILE
VALIDATE $? "setting up root password"

