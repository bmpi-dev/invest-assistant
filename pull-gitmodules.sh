#!/bin/bash
git submodule update --recursive --remote
git commit -am "update submodule invest-api"
git push
