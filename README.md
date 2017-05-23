sa-php-container
================

[![Build Status](https://travis-ci.org/softasap/sa-php-container.svg?branch=master)](https://travis-ci.org/softasap/sa-php-container)

Universal role to build customized php docker images, managed by ansible role via `ansible-container` tool.
Role supports automatic dependency installations for some of the popular php plugins

# (A)
build your own Alpine based php container with light footprint ([![](https://images.microbadger.com/badges/image/softasap/php:box-example.svg)]())


native alpine build

```YAML
conductor_base: alpine:3.5
...
services:
  php:
    from: alpine:3.5
    container_name: sa-php-demo-fpm
    roles:
      - softasap.sa-php-container
    volumes:
        - "$PWD/app/code:/www"
    environment:
      - XDEBUG=1
    ports:
      - 9000:9000
      - 9004:9004
    entrypoint: ["/entrypoint.sh"]

```


see full featured example for nginx+php-fpm in box-example folder.

# (B)

For production consider https://hub.docker.com/_/php/ as a source for base image.

Example of use in `container.yml`:

```YAML
conductor_base: debian:jessie
...
services:
  php:
    from: php:5.6.30-fpm
    container_name: sa-php-demo-fpm
    roles:
      - softasap.sa-php-container
    volumes:
        - "$PWD/app/code:/www"
    environment:
      - XDEBUG=1
    ports:
      - 9000:9000
      - 9004:9004
    entrypoint: ["/entrypoint.sh"]

```

# Role variables

Parameters configured via ansible role parameters: `timezone`, `php_extensions`.
Possibility to activate xdebug for development mode.

Without any modifications following role features can be activated:

```

#For known php extensions install dependencies for official docker php images
option_auto_dependencies: true

# install composer in path,  requires phar extension
option_install_composer: true


timezone: "Europe/Kiev"

php_family_prefix: "php5"  # valid for standalone image from scratch

php_extensions:
  - "bcmath" # ok
  - "bz2"    # ok
  - "ctype"  # ok
  - "curl"   # ok
  - "dom"    # ok
  - "fpm"    # ok, but NO AUTO DEPENDENCIES for official base image
  - "gd"     # ok
  - "gettext" #ok
  - "gmp"    # ok, but NO AUTO DEPENDENCIES for official base image
  - "iconv"  # ok
  - "json"   # ok
  - "mcrypt" # ok
  - "memcache" # ok, but NO AUTO DEPENDENCIES for official base image
  - "mssql"    # ok, but NO AUTO DEPENDENCIES for official base image
  - "mysql"  # ok
  - "odbc"   # ok, but NO AUTO DEPENDENCIES for official base image
  - "openssl" # ok, but NO AUTO DEPENDENCIES for official base image
  - "pdo"    #ok
  - "pdo_dblib" # ok, but NO AUTO DEPENDENCIES for official base image
  - "pdo_mysql" # ok
  - "pdo_odbc" # ok, but NO AUTO DEPENDENCIES for official base image
  - "pdo_pgsql" # ok
  - "pdo_sqlite" # ok
  - "phar"   # ok
  - "soap"   # ok
  - "sqlite3" # ok, but NO AUTO DEPENDENCIES for official base image
  - "xcache" # ok, but NO AUTO DEPENDENCIES for official base image
  - "xmlreader" # ok
  - "xmlrpc" # ok
  - "xsl"    # ok
  - "zip" # ok, but NO AUTO DEPENDENCIES for official base image

php_dev_extensions:
  - "xdebug"
```


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

If for some reason install is messed (manual packages updates, removals, etc) - try pip install with `--ignore-installed` flag.

later, when issue fix is released - to uninstall package installed in that way from source:

At {virtualenv}/lib/python2.7/site-packages/ (if not using virtualenv then {system_dir, like /usr/local}/lib/python2.7/dist-packages/)

remove the egg file (e.g. ansible-container.egg-link) if there is any;

from file easy-install.pth, remove the corresponding line (it should be a path to the source directory or of an egg file).

## 2
When using box-example, pay attention to `container.yml`, in particular, `conductor_base` should be derived
from the same distribution as you're building your target containers with, check list of currently supported base systems:


## 3
  If your system services are derived from different OS base images, than ... ?


Copyright and license
---------------------

Code licensed under the [BSD 3 clause] (https://opensource.org/licenses/BSD-3-Clause) or the [MIT License] (http://opensource.org/licenses/MIT).

Subscribe for roles updates at [FB] (https://www.facebook.com/SoftAsap/)

Join gitter discussion channel at [Gitter](https://gitter.im/softasap)
