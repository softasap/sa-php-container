sa-php-container
================

[![Build Status](https://travis-ci.org/softasap/sa-php-container.svg?branch=master)](https://travis-ci.org/softasap/sa-php-container)

Alpine based php container with light footprint ([![](https://images.microbadger.com/badges/image/softasap/php:box-example.svg)]())
managed by ansible role via `ansible-container` tool.

see full featured example for nginx+php-fpm in box-example folder.

For production consider https://hub.docker.com/_/php/ as a source for base image.

Example of use in `container.yml`:

```YAML
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

Expanded volumes:



Parameters configured via ansible role parameters: `timezone`, `php_extensions`.
Possibility to activate xdebug for development mode.

Without any modifications following set of extensions will be activated:

```
timezone: "Europe/Kiev"

php_family_prefix: "php5"
php_extensions:
  - "{{php_family_prefix}}-mcrypt"
  - "{{php_family_prefix}}-soap"
  - "{{php_family_prefix}}-openssl"
  - "{{php_family_prefix}}-gmp"
  - "{{php_family_prefix}}-pdo_odbc"
  - "{{php_family_prefix}}-json"
  - "{{php_family_prefix}}-dom"
  - "{{php_family_prefix}}-pdo"
  - "{{php_family_prefix}}-zip"
  - "{{php_family_prefix}}-mysql"
  - "{{php_family_prefix}}-sqlite3"
  - "{{php_family_prefix}}-apcu"
  - "{{php_family_prefix}}-pdo_pgsql"
  - "{{php_family_prefix}}-bcmath"
  - "{{php_family_prefix}}-gd"
  - "{{php_family_prefix}}-xcache"
  - "{{php_family_prefix}}-odbc"
  - "{{php_family_prefix}}-pdo_mysql"
  - "{{php_family_prefix}}-pdo_sqlite"
  - "{{php_family_prefix}}-gettext"
  - "{{php_family_prefix}}-xmlreader"
  - "{{php_family_prefix}}-xmlrpc"
  - "{{php_family_prefix}}-bz2"
  - "{{php_family_prefix}}-memcache"
  - "{{php_family_prefix}}-mssql"
  - "{{php_family_prefix}}-iconv"
  - "{{php_family_prefix}}-pdo_dblib"
  - "{{php_family_prefix}}-curl"
  - "{{php_family_prefix}}-ctype"
  - "{{php_family_prefix}}-phar"
  - "{{php_family_prefix}}-fpm"

php_dev_extensions:
  - "{{php_family_prefix}}-xdebug"
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
