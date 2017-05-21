#!/bin/bash

set -e

path=roles/softasap.sa-role-under-test
rm -rf $path || true
git clone https://${TRAVIS_REPO_SLUG} $path
cd $path && git checkout https://github.com/${TRAVIS_COMMIT} && cd ../../


ansible-playbook build.yml -e role_github_repo=${TRAVIS_REPO_SLUG} -e role_github_commit=${TRAVIS_COMMIT}
grep failed=0 build.out | grep unreachable=0 >/dev/null

if [ "$?" == "0" ]; then
    # if all looks good, give it a go
    echo "Build completed successfully. Starting the project..."
    ansible-container run -d --production
 else
    cat build.out
 fi 
