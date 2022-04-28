#!/bin/bash

#This script helps in creating and pushing files in a github repository

CURRENTDIR=${pwd}

instruct() {
    echo "Usage: ${0} [-vs] [-l LENGTH]" >&2
    echo 'Generate a random password.' >&2
    echo '  -l LENGTH  Specify the password length.' >&2
    echo '  -s         Append a special character to the password.' >&2
    echo '  -v         Increase verbosity.' >&2
    exit 1
}

firstinstruct() {
    echo "Usage: ${0} [username] [password]" >&2
    echo 'Setup username and password for repeatetive usage.' >&2
    echo '  username:     Specify github username.' >&2
    echo '  password:     Specify github password.' >&2
    
}



#Checking if username,password file exists or not
if [[ ! -f "usrpswd" ]]
then
    echo "First Time User? Lets jump in."    
    firstinstruct
    USRN=${1}
    PASS=${2}
    echo "${USRN}" > "usrpswd"
    echo "${PASS}" >> "usrpswd"
    if [[ "${?}" -ne 0 ]]
    then
        echo "Username and Password was not stored."
        exit 1
    else
        echo "Username and password successfully stored for further usage."
        echo "Congratulations! You are good to go."
    fi
fi

echo "${USRN}"
echo "${PASS}"

exit 0