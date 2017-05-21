#!/bin/bash

set -e

TRAVIS_REPO_SLUG=`git remote --verbose | grep origin | grep fetch | cut -f2 | cut -d':' -f2 | cut -d' ' -f1`
TRAVIS_COMMIT=`git rev-parse HEAD`

git config -f .projmodules --get-regexp '^submodule\..*\.path$' > tempfile

while read -u 3 path_key path
do
    url_key=$(echo $path_key | sed 's/\.path/.url/')
    url=$(git config -f .projmodules --get "$url_key")
    rm -rf $path
    git clone ${TRAVIS_REPO_SLUG} $path
    echo "$path has been initialized"
    cd $path && git checkout ${TRAVIS_COMMIT} && cd ../../

done 3<tempfile

rm tempfile

exit 1


ansible-playbook build.yml -e role_github_repo=${TRAVIS_REPO_SLUG} -e role_github_commit=${TRAVIS_COMMIT}
grep failed=0 build.out | grep unreachable=0 >/dev/null

if [ "$?" == "0" ]; then
    # if all looks good, give it a go
    echo "Build completed successfully. Starting the project..."
    ansible-container run -d --production
 else
    cat build.out
 fi 
