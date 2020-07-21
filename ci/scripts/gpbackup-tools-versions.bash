#!/bin/bash

set -ex

# get versions for gpbackup, s3_plugin and gpbackup_manager
pushd gpbackup-go-components
      tar -xzf go_components.tar.gz
      GPBACKUP_VERSION=$(cat gpbackup_version)
      cp *_version ../gpbackup-tools-versions/
popd
echo ${GPBACKUP_VERSION} > gpbackup-tools-versions/pkg_version

# get version for ddboost_plugin
pushd gpbackup_ddboost_plugin
      DDBOOST_PLUGIN_VERSION=1.4.1
popd
echo ${DDBOOST_PLUGIN_VERSION} > gpbackup-tools-versions/ddboost_plugin_version
