#!/bin/bash

set -e -u

sed -i \
    -e "s#@@CANARYD_BASE_URL@@#${CANARYD_BASE_URL}#g" \
    -e "s#@@CHECKS_URL@@#${CHECKS_URL}#g" \
    /srv/canary-ember/dist/assets/app.js

