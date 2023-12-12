#!/bin/bash

if [[ "$PLATFORM" == "prod" ]]; then
    echo "Platform set to Production"
elif [[ "$PLATFORM" == "dev" ]]; then
    echo "Platform set to dev"
    rm -rf /cerebro-core/*
    if [ -z "${GIT_SYNC_BRANCH}" ]; then
        git clone $GIT_SYNC_REPO /cerebro-core
    else
        git clone $GIT_SYNC_REPO -b $GIT_SYNC_BRANCH /cerebro-core
    fi
    clone_status=$?
    if [ $clone_status -eq 0 ]; then
        echo "Successfully cloned the repository."

        # set permissions
        chmod -R +rx /cerebro-core

        # add dir as safe in git and ignore file permission changes
        git config core.fileMode false
        git config --global --add safe.directory /cerebro-core

    else
        echo "An error occurred while running git clone."
    fi
else
    echo "Unknown platform"
fi
