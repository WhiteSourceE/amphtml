#!/bin/bash
#
# Copyright 2021 The AMP HTML Authors. All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS-IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the license.

# Script used by AMP's CI builds to restore any build outputs from previous jobs
# in the workflow.

set -e

GREEN() { echo -e "\033[0;32m$1\033[0m"; }
YELLOW() { echo -e "\033[0;33m$1\033[0m"; }
CYAN() { echo -e "\033[0;36m$1\033[0m"; }

MERGABLE_OUTPUT_DIRS="build dist dist.3p dist.tools"
WORKSPACE_DIR="/tmp/restored-workspace"

if [[ -d "${WORKSPACE_DIR}/builds" ]]; then
  echo $(GREEN "Installing rsync...")
  sudo apt update && sudo apt install rsync

  echo $(GREEN "Restoring build output from workspace")
  for RESTORED_BUILD_DIR in ${WORKSPACE_DIR}/builds/*; do
    for OUTPUT_DIR in ${MERGABLE_OUTPUT_DIRS}; do
      RESTORED_DIR="${RESTORED_BUILD_DIR}/${OUTPUT_DIR}"
      if [[ -d "${RESTORED_DIR}" ]]; then
        echo "*" $(GREEN "Merging") $(CYAN "${RESTORED_DIR}") $(GREEN "into") $(CYAN "./${OUTPUT_DIR}")
        rsync -a "${RESTORED_DIR}/" "./${OUTPUT_DIR}"
      fi
    done
    # Bento components are compiled inside the extension source file.
    for RESTORED_COMPONENT_DIR in ${RESTORED_BUILD_DIR}/extensions/*/?.?/dist; do
      OUTPUT_DIR=${RESTORED_COMPONENT_DIR##$RESTORED_BUILD_DIR/}
      echo "*" $(GREEN "Merging") $(CYAN "${RESTORED_COMPONENT_DIR}") $(GREEN "into") $(CYAN "./${OUTPUT_DIR}")
      mkdir -p $RESTORED_DIR
      rsync -a "${RESTORED_COMPONENT_DIR}/" "./${OUTPUT_DIR}"
    done
  done
else
  echo $(YELLOW "Workspace does not contain any build outputs to restore")
fi
