#!/bin/bash

kubeval $1
kube-linter lint $1
