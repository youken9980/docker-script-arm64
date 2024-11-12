#!/bin/sh

set -eux

ssh-keygen -C "${GIT_USER_EMAIL}"
