#!/bin/sh
set -e

CLEAR='\033[0m'
RED='\033[0;31m'

# ansible env settings
ANSIBLE_RETRY_FILES_ENABLED=0
ANSIBLE_SSH_ARGS="-C -o ControlMaster=auto -o ControlPersist=60s -o IdentitiesOnly=yes"

echo "PLAYBOOK=${PLAYBOOK}"
echo "KEY_FILE=${KEY_FILE}"
echo "ARTIFACT=${ARTIFACT}"
echo "RUN_DIR=${RUN_DIR}"
echo "FALLBACK=${FALLBACK}"
echo "CONFIG_FILE=${CONFIG_FILE}"

echo "changing to $RUN_DIR"
cd ${RUN_DIR}

echo "retrieving $PLAYBOOK"
aws s3 cp ${PLAYBOOK} .
# 3. Untar into /playbook (if dir with same name as tar exists, cd into it)
# Only supporting tar for now
if [[ ${PLAYBOOK##*.} == "tar" ]]; then
  FILENAME=${PLAYBOOK##*/}
  BASENAME=${FILENAME%.*}
  echo "Calling: tar -vxf ${FILENAME}"
  `tar -xf ${FILENAME}`
  if [ -d ${BASENAME} ]; then
    echo "Calling: cd ${BASENAME}"
    cd ${BASENAME}
  fi
fi

echo "retrieving $KEY_FILE"
aws s3 cp ${KEY_FILE} .
KEY_FILENAME=${KEY_FILE##*/}
chmod 0600 $KEY_FILENAME

ARTIFACT=${ARTIFACT/.s3.amazonaws.com/} # need to do this until boto supports the new aws scheme.
echo "retrieving $ARTIFACT"
aws s3 cp ${ARTIFACT} .
# Convert the rpm name into the package.yml play to run
if [[ ${ARTIFACT##*.} == "rpm" ]]; then
  ARTIFACT_FILE=${ARTIFACT##*/}
  PACKAGE=${ARTIFACT_FILE%-*-*}
  TARGET="${PACKAGE}.yml"
fi

# if the package.yml doesn't exist, use the fallback if it was provided.
if [[ ! -f ${TARGET} ]]; then
  echo "$TARGET does not exist, falling back to $FALLBACK"
  TARGET=${FALLBACK}
fi

# 5. Run ansible-playbook
echo "Calling: ansible-playbook -e @${CONFIG_FILE} --key-file ${KEY_FILENAME} ${TARGET}"
ansible-playbook -e @${CONFIG_FILE} --key-file ${KEY_FILENAME} ${TARGET}