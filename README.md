# alpine based php container

[![Build Status](https://travis-ci.org/softasap/sa-php-container.svg?branch=master)](https://travis-ci.org/softasap/sa-php-container)



# Temporary hints


## 1

at a moment ansible-container is highly under development. You might spot issues, that are fixed in develop branch only.

In that case you might need to install ansible-container from source, i.e.

```shell

git clone https://github.com/ansible/ansible-container.git
cd ansible-container
git checkout develop
pip install -e .[docker,openshift]
```

## 2
When using box-example, pay attention to `container.yml`, in particular, `conductor_base` should be derived
from the same distribution as you're building your target containers with, check list of currently supported base systems:


##3
  If your system is derived from different OS base images, than ...
