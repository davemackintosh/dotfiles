#!/bin/env bash

loadkeys $1 &&
timedatectl set-ntp true
