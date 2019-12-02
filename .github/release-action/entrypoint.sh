#!/bin/bash

hub checkout master

# FIND LAST RELEASE, GET HASH AND DATE OF HASH
RESULT=$(curl -H "Authorization: token ${GITHUB_TOKEN}" "https://api.github.com/repos/${GITHUB_REPOSITORY}/releases/latest")
LAST_COMMMIT=$(echo $RESULT | jq -r '.target_commitish')
LAST_RELEASE_DATE=$(echo $RESULT | jq -r '.created_at')

# GET ALL COMMITS FROM LAST RELEASE UP TO CURRENT
# COMMITS=$(curl -H "Authorization: token ${GITHUB_TOKEN}" "https://api.github.com/repos/${GITHUB_REPOSITORY}/compare/${LAST_COMMMIT}...${COMMIT_SHA}")
# For this way, use .basecommit.commit.message instead of simply .commit.message
COMMITS=$(curl -H "Authorization: token ${GITHUB_TOKEN}" "https://api.github.com/repos/${GITHUB_REPOSITORY}/commits?since=${LAST_RELEASE_DATE}")

FILENAME=release_notes.txt
echo "${RELEASE_TITLE}_v${VERSION_NUMBER}" > $FILENAME
echo "" >> ${FILENAME}
echo "## What's changed " >> ${FILENAME}
echo "" >> ${FILENAME}

# CAPTURE ALL MESSAGES FROM ALL COMMITS
IFS=$'\n'
for item in $(echo ${COMMITS} | jq -r '.[]')
do
    MESSAGE=$(jq -r '.commit.message')
    AUTHOR=$(jq -r '.author.login')
    echo -n '* ' >> ${FILENAME}
    echo -n ${MESSAGE//[$'\t\r\n']} >> ${FILENAME}
    echo "@"${AUTHOR//[$'\t\r\n']} >> ${FILENAME}
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
