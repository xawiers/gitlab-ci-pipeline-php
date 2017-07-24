Gitlab CI runner for PHP applications
========================
> Docker image with everything you'll need to build and test PHP applications on Gitlab Continous Integration

### Simple ```.gitlab-ci.yml``` using mariadb service

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
  image: dockerphp/gitlab-ci-runner-php:7.0
  script:
    - ant
```

### Advanced ```.gitlab-ci.yml``` using mysql service, stages and cache

```yaml
stages:
  - test
  - deploy

# Variables
variables:
  MYSQL_ROOT_PASSWORD: ci
  MYSQL_USER: ci
  MYSQL_PASSWORD: ci
  MYSQL_DATABASE: ci
  DB_HOST: mariadb

# Speed up builds
cache:
  key: $CI_BUILD_REF_NAME # changed to $CI_COMMIT_REF_NAME in Gitlab 9.x
  paths:
    - vendor
    - node_modules
    - public
    - ~/.composer/cache/files
    - ~/.yarn-cache

test:
  stage: test
  services:
    - mysql:5.7
  image: dockerphp/gitlab-ci-runner-php:5.6
  script:
    - yarn clean
    - yarn
    - gulp
    - composer install --prefer-dist --no-ansi --no-interaction --no-progress --no-scripts
    - cp .env.dist .env
    - php bin/console hautelook_alice:doctrine:fixtures:load
    - ./vendor/bin/phpunit -v --coverage-text --colors=never --stderr
  artifacts:
    paths:
      - ./var/logs # for debugging
    expire_in: 1 days
    when: always

deploy:
  stage: deploy
  image: dockerphp/gitlab-ci-runner-php:7.0
  script:
    - echo "Your deploy script"
  only:
    - master
  when: on_success
```
---

[docker_hub]: https://hub.docker.com/_/php/