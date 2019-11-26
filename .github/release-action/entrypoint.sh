#!/bin/bash

hub checkout master
MAJOR_VERSION=`cat build.gradle | grep 'majorVersion = ' | awk '{print $3}'`
MINOR_VERSION=`cat build.gradle | grep 'minorVersion = ' | awk '{print $3}'`
PATCH_VERSION=`cat build.gradle | grep 'patchVersion = ' | awk '{print $3}'`
VERSION_NAME=${MAJOR_VERSION}.${MINOR_VERSION}.${PATCH_VERSION}.${BUILD_NUMBER}
hub release create -a ./${APP_FOLDER}/build/outputs/${OUTPUT_TYPE}/*.${OUTPUT_TYPE} -m "${RELEASE_TITLE}_v${VERSION_NAME}" -t ${COMMIT_SHA} v${VERSION_NAME}

