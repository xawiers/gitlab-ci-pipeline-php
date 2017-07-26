Gitlab CI pipeline for PHP applications
========================
> Docker image with everything you'll need to build and test PHP applications on Gitlab Continous Integration

![Docker Pulls](https://img.shields.io/docker/pulls/dockerphp/gitlab-ci-pipeline.svg)
[![Build Status](https://travis-ci.org/php-docker/gitlab-ci-pipeline.svg?branch=master)](https://travis-ci.org/php-docker/gitlab-ci-pipeline)

# Supported tags
| Tag | Image | Layers |
| --- | --- |  --- |
| ```7.1```| ```dockerphp/gitlab-ci-pipeline:7.1``` | [![](https://images.microbadger.com/badges/image/dockerphp/gitlab-ci-pipeline:7.1.svg)](https://microbadger.com/images/dockerphp/gitlab-ci-pipeline:7.1)| 
| ```7.0```| ```dockerphp/gitlab-ci-pipeline:7.0``` | [![](https://images.microbadger.com/badges/image/dockerphp/gitlab-ci-pipeline:7.0.svg)](https://microbadger.com/images/dockerphp/gitlab-ci-pipeline:7.0)|
| ```5.6```| ```dockerphp/gitlab-ci-pipeline:5.6``` | [![](https://images.microbadger.com/badges/image/dockerphp/gitlab-ci-pipeline:5.6.svg)](https://microbadger.com/images/dockerphp/gitlab-ci-pipeline:5.6)|

Based on [Official PHP images Alpine](https://hub.docker.com/_/php/)

All versions come with:
* Dependency Manager or Tools
    * [Node][nodejs]
    * [composer][composer]
    * [Yarn][yarn]
* Automation of tasks
    * [Apache Ant][apache_ant]
    * [Apache Ant][apache_ant]
* [PHP Quality Assurance][phpqa]:
    * [PHP Mess Detector][phpmd]
    * [PhpMetrics][phpmetric]
    * [PHP Depend][pdepend]
    * [PHP Copy/Paste Detector][phpcpd]
    * [PHP CodeSniffer][phpcs]
    * [PHP Documentation Generator][phpdox]
    * [PHP Loc][phploc]
* JS Quality Assurance
    * [JSHint][jshint]

### Simple `.gitlab-ci.yml`

```yaml
# Variables
variables:
  COMPOSER_ALLOW_SUPERUSER: "1"

test:
  stage: test
  image: dockerphp/gitlab-ci-pipeline:7.0
  script:
    - ant 
```

### Simple with `mariadb` `.gitlab-ci.yml`

```yaml
# Variables
variables:
  MYSQL_ROOT_PASSWORD: ci
  MYSQL_USER: ci
  MYSQL_PASSWORD: ci
  MYSQL_DATABASE: ci
  DB_HOST: mariadb

test:
  stage: test
  services:
    - mariadb:10.3
  image: dockerphp/gitlab-ci-pipeline:7.0
  script:
    - make test 
```

### Multi versions `.gitlab-ci.yml`

```yaml
cache:
    paths:
        - vendor/

variables:
    COMPOSER_CACHE_DIR: "/storage"
    COMPOSER_DISABLE_XDEBUG_WARN: "1"
    COMPOSER_VENDOR_DIR: "/storage/vendor/${CI_PROJECT_ID}/${CI_BUILD_REF_NAME}"
    COMPOSER_ALLOW_SUPERUSER: "1"

stages:
    - test

cache:
  key: $CI_COMMIT_REF_NAME
  paths:
    - vendor
    - node_modules
    - public
    - ~/.composer/cache/files
    - ~/.yarn-cache

test:7.1:
    image: dockerphp/gitlab-ci-pipeline:7.1
    script:
        - ant -Dbasedir=`pwd` -buildfile build/ci_gitlab.xml

test:7.0:
    image: dockerphp/gitlab-ci-pipeline:7.0
    script:
        - ant -Dbasedir=`pwd` -buildfile build/ci_gitlab.xml
```

---

[docker_hub]: https://hub.docker.com/_/php/
[composer]: https://getcomposer.org/
[nodejs]: https://nodejs.org/en/
[yarn]: https://yarnpkg.com
[apache_ant]: http://ant.apache.org/
[phpqa]: https://phpqa.io/
[phpmd]: https://phpmd.org/
[phpmetric]: http://www.phpmetrics.org/
[pdepend]: https://pdepend.org/
[phpcpd]: https://github.com/sebastianbergmann/phpcpd
[phpcs]: https://github.com/squizlabs/PHP_CodeSniffer
[phpdox]: http://phpdox.de/
[phploc]: https://github.com/sebastianbergmann/phploc
[jshint]: http://jshint.com