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

> Based on [Official PHP images Alpine](https://hub.docker.com/_/php/) and all versions come with:

* Dependency Manager:
    * [Node][nodejs]
    * [composer][composer]
    * [Yarn][yarn]
* Automation of tasks:
    * [Apache Ant][apache_ant]
    * [Make][make]
* PHP Quality Assurance:
    * [PHP Mess Detector][phpmd]
    * [PhpMetrics][phpmetric]
    * [PHP Depend][pdepend]
    * [PHP Copy/Paste Detector][phpcpd]
    * [PHP CodeSniffer][phpcs]
    * [PHP Documentation Generator][phpdox]
    * [PHP Loc][phploc]
* JS Quality Assurance
    * [JSHint][jshint]

## First of all you must have installed gitlab-ci-runner

* [Install Gitlab-ci-runner](./docs/1-install-gitlab-runner.md)
* [Register an runner](./docs/2-register-runner.md)

## Configuration of your jobs with .gitlab-ci.yml

### Basic configuration 

```yaml
image: dockerphp/gitlab-ci-pipeline:7.1

cache:
  paths:
  - vendor/

variables:
    COMPOSER_DISABLE_XDEBUG_WARN: "1"
    COMPOSER_ALLOW_SUPERUSER: "1"

test:app:
    script:
        - composer install --prefer-dist --no-interaction --no-progress
        - ./vendor/bin/phpunit --coverage-text --colors=never
        - ./vendor/bin/php-cs-fixer fix --diff --dry-run -v

```

### Using the `mariadb` service and Make

```yaml
variables:
    COMPOSER_DISABLE_XDEBUG_WARN: "1"
    COMPOSER_ALLOW_SUPERUSER: "1"
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

### Multi versions and Apache-Ant

```yaml
cache:
    paths:
        - vendor/

variables:
    COMPOSER_DISABLE_XDEBUG_WARN: "1"
    COMPOSER_ALLOW_SUPERUSER: "1"

stages:
    - test

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
[make]: https://www.gnu.org/software/make/
[phpmd]: https://phpmd.org/
[phpmetric]: http://www.phpmetrics.org/
[pdepend]: https://pdepend.org/
[phpcpd]: https://github.com/sebastianbergmann/phpcpd
[phpcs]: https://github.com/squizlabs/PHP_CodeSniffer
[phpdox]: http://phpdox.de/
[phploc]: https://github.com/sebastianbergmann/phploc
[jshint]: http://jshint.com
