#!/bin/bash

set -x

hub checkout master


# FIND LAST RELEASE, GET HASH AND DATE OF HASH
RESULT=$(curl -H "Authorization: token ${GITHUB_TOKEN}" "https://api.github.com/repos/${GITHUB_REPOSITORY}/releases/latest")
LAST_COMMMIT=$(echo $RESULT | grep -Po '(?<="target_commitish": ")[^"]+') 
# "target_commitish": "0628a50afe7afdf5fccf14bad02dadcdf859f055",
# LAST_RELEASE_DATE=$(echo $RESULT | grep -Po '(?<="created_at": ")[^"]+') # TODO: pulls both 'created_at' dates, need only first.
# "created_at": "2019-10-09T02:52:17Z",


set +x
# GET ALL COMMITS FROM LAST RELEASE UP TO CURRENT
COMMITS=$(curl -H "Authorization: token ${GITHUB_TOKEN}" "https://api.github.com/repos/${GITHUB_REPOSITORY}/compare/${LAST_COMMMIT}...${COMMIT_SHA}")
# COMMITS=$(curl -H "Authorization: token ${GITHUB_TOKEN}" "https://api.github.com/repos/${GITHUB_REPOSITORY}/commits?since=${LAST_RELEASE_DATE}")
set -x


set +x # Too much info to print.
# GET ALL PULL REQUESTS FROM LAST RELEASE UP TO CURRENT
PULL_REQUESTS=$(curl -H "Authorization: token ${GITHUB_TOKEN}" "https://api.github.com/repos/${GITHUB_REPOSITORY}/pulls?state=closed&")
set -x


FILENAME=release_notes.txt
echo "${RELEASE_TITLE}_v${VERSION_NUMBER}" > $FILENAME
echo "" >> ${FILENAME}
echo "## What's changed " >> ${FILENAME}
echo "" >> ${FILENAME}


# CAPTURE ALL MESSAGES FROM ALL COMMITS AND PULL REQUESTS # https://unix.stackexchange.com/questions/477210/looping-through-json-array-in-shell-script
# COMMITS
IFS=$'\n'
for item in $(echo ${COMMITS} | jq -r '.[] .commit.message')
do
    echo -n '* ' >> ${FILENAME}
    echo ${item//[$'\t\r\n']} >> ${FILENAME}
done





echo "* JUNK: Update release-drafter.yml (#85) @MikeHamilton-RW" >> $FILENAME
echo "* Update and rename release-drafter.yaml to release-drafter.yml (#84) @MikeHamilton-RW" >> $FILENAME
echo "* Update release-drafter.yaml (#83) @MikeHamilton-RW" >> $FILENAME
echo "* Update branch_build_test_lint.yaml (#82) @MikeHamilton-RW" >> $FILENAME
echo "* Update release-drafter.yaml (#81) @MikeHamilton-RW" >> $FILENAME
echo "* merge to master (#80) @MikeHamilton-RW" >> $FILENAME
echo "* Optimize action workflow (#79) @MikeHamilton-RW" >> $FILENAME
echo "* Commit of last release: $LAST_COMMMIT"
echo "* Date of last release: $LAST_RELEASE_DATE"
# Need to capture all previous commit meessages.
hub release create -a ./${APP_FOLDER}/build/outputs/${OUTPUT_TYPE}/*.${OUTPUT_TYPE} -F $FILENAME -t ${COMMIT_SHA} v${VERSION_NUMBER}

rm $FILENAME

# for k in $(jq '.children.values | keys | .[]' file); do
#     value=$(jq -r ".children.values[$k]" file);
#     name=$(jq -r '.path.name' <<< "$value");
#     type=$(jq -r '.type' <<< "$value");
#     size=$(jq -r '.size' <<< "$value");
#     printf '%s\t%s\t%s\n' "$name" "$type" "$size";
# done | column -t -s$'\t'

set +x
