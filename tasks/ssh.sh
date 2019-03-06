#!/bin/env bash

test ! -f "$HOME/.ssh/id_rsa.pub" && ssh-keygen -f id_rsa -t rsa -N '' &&
echo "\nUpload your ssh key to the relevant services:\n" &&
cat "$HOME/.ssh/id_rsa.pub"
