#!/bin/bash

cp -r backend/coverage/ ./
sed -i 's+/app/app/+backend/app/+g' coverage/.resultset.json
curl -L https://codeclimate.com/downloads/test-reporter/test-reporter-latest-linux-amd64 > ./cc-test-reporter
chmod +x ./cc-test-reporter
./cc-test-reporter before-build
./cc-test-reporter after-build --exit-code 0 -t simplecov -r eaeb535f7c1b762ef782d99d28b2c3d22dff149d1ccdb7a698432e86345609d0
