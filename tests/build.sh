#!/bin/bash

set -e

path=roles/softasap.sa-role-under-test
rm -rf $path || true
git clone https://github.com/${TRAVIS_REPO_SLUG}.git $path
cd $path && git checkout ${TRAVIS_COMMIT} && cd ../../


ansible-playbook build.yml -e role_github_repo=${TRAVIS_REPO_SLUG} -e role_github_commit=${TRAVIS_COMMIT} -vvvv

if [ "$?" == "0" ]; then
    # if all looks good, give it a go
    echo "Build completed successfully. Starting the project..."
    ansible-container run --debug --roles-path ./roles/ -- -vvv
fi
