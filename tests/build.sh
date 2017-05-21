#!/bin/bash

set -e

TRAVIS_REPO_SLUG=`git remote --verbose | grep origin | grep fetch | cut -f2 | cut -d':' -f2 | cut -d' ' -f1`
TRAVIS_COMMIT=`git rev-parse HEAD`

ansible-playbook build.yml -e role_github_repo=${TRAVIS_REPO_SLUG} -e role_github_commit=${TRAVIS_COMMIT}
grep failed=0 build.out | grep unreachable=0 >/dev/null

if [ "$?" == "0" ]; then
    # if all looks good, give it a go
    echo "Build completed successfully. Starting the project..."
    ansible-container run -d --production
 else
    cat build.out
 fi 
