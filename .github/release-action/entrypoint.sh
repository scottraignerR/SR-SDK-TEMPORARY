#!/bin/bash

hub checkout master

# FIND LAST RELEASE, GET HASH AND DATE OF HASH
RESULT=$(curl -H "Authorization: token ${GITHUB_TOKEN}" "https://api.github.com/repos/${GITHUB_REPOSITORY}/releases/latest")
LAST_COMMMIT=$(echo $RESULT | jq -r '.target_commitish')
LAST_RELEASE_DATE=$(echo $RESULT | jq -r '.created_at')

# GET ALL COMMITS FROM LAST RELEASE UP TO CURRENT
# COMMITS=$(curl -H "Authorization: token ${GITHUB_TOKEN}" "https://api.github.com/repos/${GITHUB_REPOSITORY}/compare/${LAST_COMMMIT}...${COMMIT_SHA}")
# For this way, use .basecommit.commit.message instead of simply .commit.message as done below
COMMITS=$(curl -H "Authorization: token ${GITHUB_TOKEN}" "https://api.github.com/repos/${GITHUB_REPOSITORY}/commits?since=${LAST_RELEASE_DATE}")

FILENAME=release_notes.txt
echo "${RELEASE_TITLE}_v${VERSION_NUMBER}" > $FILENAME
echo "" >> ${FILENAME}
echo "## What's changed since the last release:" >> ${FILENAME}
echo "#### Last release date: $LAST_RELEASE_DATE" >> ${FILENAME}
echo "#### Last release commit: $LAST_COMMMIT" >> ${FILENAME}
echo "" >> ${FILENAME}

# CAPTURE ALL MESSAGES FROM ALL COMMITS
IFS=$''
echo ${COMMITS} | jq '.[] | .commit.message, .sha, .html_url, .author.login, .commit.author.date' | (
    while read message; 
    do
        out_message=$(echo "* "$message | tr -d '"')
        read sha
        read html_url
        out_message+=$(echo " [${sha:0:8}]($html_url)" | tr -d '"')
        read login
        if [ ! -z "$login" ]; then
            out_message+=$(echo " @"$login | tr -d '"')
            read date
            if [ ! -z "$date" ]; then
                out_message+=$(echo " "$date | tr -d '"')
            fi
        fi
        echo $out_message >> ${FILENAME}
    done
)

# one line, ugly solution. Not ideal.
# echo ${COMMITS} | jq -r '.[] | "* " + .commit?.message + " @" + .author?.login + " " + .commit.author.date' >> $FILENAME

echo "* Commit of last release: $LAST_COMMMIT"
echo "* Date of last release: $LAST_RELEASE_DATE"

hub release create -a ./${APP_FOLDER}/build/outputs/${OUTPUT_TYPE}/*.${OUTPUT_TYPE} -F $FILENAME -t ${COMMIT_SHA} v${VERSION_NUMBER}

rm $FILENAME

