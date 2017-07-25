Gitlab CI pipeline for PHP applications
========================
> Docker image with everything you'll need to build and test PHP applications on Gitlab Continous Integration

![Docker Pulls](https://img.shields.io/docker/pulls/dockerphp/gitlab-ci-pipeline.svg)

- ```7.1```, ```dockerphp/gitlab-ci-pipeline:7.1``` [(7.1/Dockerfile)] [![](https://images.microbadger.com/badges/image/dockerphp/gitlab-ci-pipeline:7.1.svg)](https://microbadger.com/images/dockerphp/gitlab-ci-pipeline:7.1) 
- ```7.0```, ```dockerphp/gitlab-ci-pipeline:7.0``` [![](https://images.microbadger.com/badges/image/dockerphp/gitlab-ci-pipeline:7.0.svg)](https://microbadger.com/images/dockerphp/gitlab-ci-pipeline:7.0)
- ```5.6```, ```dockerphp/gitlab-ci-pipeline:5.6``` [![](https://images.microbadger.com/badges/image/dockerphp/gitlab-ci-pipeline:5.6.svg)](https://microbadger.com/images/dockerphp/gitlab-ci-pipeline:5.6)

### Simple

```yaml
# Variables
variables:
  COMPOSER_ALLOW_SUPERUSER: "1"

test:
  stage: test
  services:
    - mariadb:10.3
  image: dockerphp/gitlab-ci-pipeline:7.0
  script:
    - ant 
```

### Simple with mariadb

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
    - ant 
```

### Multi versions

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


test:5.6:
    image: dockerphp/gitlab-ci-pipeline:5.6
    script:
        - ant -Dbasedir=`pwd` -buildfile build/ci_gitlab.xml

test:7.0:
    image: dockerphp/gitlab-ci-pipeline:7.0
    script:
        - ant -Dbasedir=`pwd` -buildfile build/ci_gitlab.xml
```
---

[docker_hub]: https://hub.docker.com/_/php/
