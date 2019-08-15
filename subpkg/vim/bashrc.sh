#!/bin/bash
gem_path="$HOME/.gem/bin"

if [[ ${PATH} != *"$gem_path"* ]] ; then
export PATH="$PATH$gem_path"
fi