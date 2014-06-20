#!/bin/bash

set -e -u -x

cd /tmp/src

yum localinstall -y http://nginx.org/packages/centos/6/noarch/RPMS/nginx-release-centos-6-0.el6.ngx.noarch.rpm

yum install -y nginx git nodejs-0.10.28-1 ## nodejs from my yum repo

mv nginx.conf /etc/nginx/
mv program-*.conf /etc/supervisor.d/
mv rewrite-config.sh /usr/local/bin/

git clone https://github.com/jagthedrummer/canary-ember.git /srv/canary-ember
cd /srv/canary-ember
git checkout aaaf986a36ea6119f4d4edfcdfb5574ce49a8aa3

export PATH=$PWD/node_modules/.bin:$PATH

npm install bower@1.3.5
npm install

## choose a specific ember version
## this is the result of running interactively and specifying option "!1".
sed -i -e 's#"ember": "e-tag:f11e697e9"#"ember": "e-tag:7c86bb3b1"#' bower.json

## wtf. https://github.com/bower/bower/pull/1163
CI=true bower install --allow-root

mv vendor/ember/index.js vendor/ember/ember.js

mv /tmp/src/{application,measurement}.js app/adapters/

ember build

## cleanup
cd /
yum clean all
rm -rf /var/tmp/yum-root* /tmp/src /srv/canary-ember/node_modules
