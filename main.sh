#!/bin/bash

#This script helps in creating and pushing files in a github repository
help() {
    echo "reset username password"
}

firstinstruct() {
    echo "Usage: ${0} [username] [password]" >&2
    echo 'Setup username and password for repeatetive usage.' >&2
    echo '  username:     Specify github username.' >&2
    echo '  password:     Specify github password.' >&2
    exit 1
}

# if [[ "${UID}" -ne 0 ]]
# then
#     echo 'Please run with sudo or root.' >&2
#     exit 1
# fi

#Checking if username,password file exists or not
if [[ ! -f "usrpswd.csv" ]]
then
    echo "" > "usrpswd.csv"
    echo "First Time User? Lets jump in."    
    firstinstruct
fi

USERNAM=$(awk -F: 'NR==1 {print $1}' usrpswd.csv)
PASS=$(awk -F: 'NR==2 {print $1}' usrpswd.csv)


if [[ "${#}" -eq 2 ]]
then
    USRN=${1}
    PASS=${2}
    echo "${USRN}" > "usrpswd.csv"
    echo "${PASS}" >> "usrpswd.csv"
    if [[ "${?}" -ne 0 ]]
    then
        echo "Username and Password was not stored."
        exit 1
    else
        echo "Username and password successfully stored for further usage."
        echo "Congratulations! You are good to go."
        # pushinstruct
    fi
elif [[ "${#}" -eq 0 ]]
then
    echo "Give name to your remote repository:"
    read REPONAME
    echo "Repo description: "
    read DESC
    echo "Project Path: "
    read PROPATH

    cd "${PROPATH}"

    git init

    echo "Create ReadMe?(y/n)"
    read TEMP
    if [[ TEMP == "y" ]]
    then
        touch README.MD
        git add README.MD
        git commit -m 'first commit, repo created.'
    fi

    curl -H "Authorization: token $PASS" https://api.github.com/user/repos -d "{\"name\":\"$REPONAME\"}"

    git add .

    git commit -m "initial commit"

    git remote add origin https://github.com/${USERNAM}/${REPONAME}.git
    git push --set-upstream origin master
    cd "$PROJECT_PATH"

    if [[ ${?} -eq 0 ]]
    then
    echo "Done. Go to https://github.com/$USERNAM/$REPO_NAME to see." 
    echo "--- You're now in your project root. ---"
    fi
else
    firstinstruct
fi


exit 0