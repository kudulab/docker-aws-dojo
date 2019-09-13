#!/bin/bash

if [[ -d ${dojo_identity}/.aws ]]; then
    cp -pr ${dojo_identity}/.aws ${dojo_home}/.aws
    chown dojo:dojo -R ${dojo_home}/.aws
fi