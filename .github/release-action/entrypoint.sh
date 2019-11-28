#!/bin/bash

hub checkout master
MAJOR_VERSION=`cat build.gradle | grep 'majorVersion = ' | awk '{print $3}'`
MINOR_VERSION=`cat build.gradle | grep 'minorVersion = ' | awk '{print $3}'`
PATCH_VERSION=`cat build.gradle | grep 'patchVersion = ' | awk '{print $3}'`
VERSION_NAME=${MAJOR_VERSION}.${MINOR_VERSION}.${PATCH_VERSION}.${BUILD_NUMBER}
# hub release create -a ./${APP_FOLDER}/build/outputs/${OUTPUT_TYPE}/*.${OUTPUT_TYPE} -m "${RELEASE_TITLE}_v${VERSION_NAME}" -t ${COMMIT_SHA} v${VERSION_NAME}

FILENAME=release_notes.txt
echo "${RELEASE_TITLE}_v${VERSION_NAME}" > $FILENAME
echo "" >> $FILENAME
echo "## What's changed " >> $FILENAME
echo "" >> $FILENAME
echo "* Update release-drafter.yml (#85) @MikeHamilton-RW" >> $FILENAME
echo "* Update and rename release-drafter.yaml to release-drafter.yml (#84) @MikeHamilton-RW" >> $FILENAME
echo "* Update release-drafter.yaml (#83) @MikeHamilton-RW" >> $FILENAME
echo "* Update branch_build_test_lint.yaml (#82) @MikeHamilton-RW" >> $FILENAME
echo "* Update release-drafter.yaml (#81) @MikeHamilton-RW" >> $FILENAME
echo "* merge to master (#80) @MikeHamilton-RW" >> $FILENAME
echo "* Optimize action workflow (#79) @MikeHamilton-RW" >> $FILENAME
# Need to capture all previous commit meessages.
hub release create -a ./${APP_FOLDER}/build/outputs/${OUTPUT_TYPE}/*.${OUTPUT_TYPE} -F notes.txt -t ${COMMIT_SHA} v${VERSION_NAME}

rm release_notes.txt
