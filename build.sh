#!/bin/bash

# resulting images namespace on docker hub
NAMESPACE=dockerphp/gitlab-ci-pipeline

# publish the built images
PUBLISH=false

# enabled repositories for the build
REPOSITORIES=$1

# enable all repositories if any specified
if [[ -z $REPOSITORIES ]]; then
    REPOSITORIES="image"
fi

# for returning later to the main directory
ROOT_DIRECTORY=`pwd`

# function for building imagesœ
function build_repository {
#    docker rmi $(docker images | grep -v '$NAMESPACE' | awk {'print $3'})

    # read repository configuration
    source $ROOT_DIRECTORY/buildvars

    # build all enabled versions
    for TAG in $TAGS; do
      # some verbose
      echo $'\n\n'"--> Building $NAMESPACE:$TAG"$'\n'
      docker build -t $NAMESPACE:$TAG -f $ROOT_DIRECTORY/$REPOSITORY/$TAG/Dockerfile .

        for VARI in $VARIANT; do
          if [ -d "$ROOT_DIRECTORY/$REPOSITORY/$TAG/$VARI" ]; then
            echo $'\n\n'"--> Building variant $NAMESPACE-$REPOSITORY:$TAG-$VARI"$'\n'
            docker build -t $NAMESPACE:$TAG-$VARI -f $ROOT_DIRECTORY/$REPOSITORY/$TAG/$VARI/Dockerfile .
          fi
        done
    done

    # create the latest tag
    echo $'\n\n'"--> Aliasing $LATEST as 'latest'"$'\n'
    docker tag $NAMESPACE:$LATEST $NAMESPACE-$REPOSITORY:latest
}

# function for publishing images
function publish_repository {
    # read repository configuration
    source $ROOT_DIRECTORY/buildvars

    # publish all enabled versions
    for TAG in $TAGS; do
      # some verbose
      echo $'\n\n'"--> Publishing $NAMESPACE:$TAG"$'\n'
      # publish
      docker push $NAMESPACE:$TAG

        for VARI in $VARIANT; do
          if [ -d "$ROOT_DIRECTORY/$REPOSITORY/$TAG/$VARI" ]; then
            echo $'\n\n'"--> Building variant $NAMESPACE:$TAG-$VARI"$'\n'
            docker push $NAMESPACE:$TAG-$VARI
          fi
        done
    done

    # create the latest tag
    echo $'\n\n'"--> Publishing $NAMESPACE:latest (from $LATEST)"$'\n'
    docker push $NAMESPACE:latest
}

# for each enabled repository
for REPOSITORY in $REPOSITORIES; do

  # build the repository
  build_repository $REPOSITORY

  # If publishing is enabled
  if [ $PUBLISH == true ]; then
    # Push the built image
    publish_repository $REPOSITORY
  fi
done
