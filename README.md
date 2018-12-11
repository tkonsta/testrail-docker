# About

This version is forked from https://github.com/gavrie/testrail-docker and has updated versions of ubuntu, php and mysql, which work for the current (11/2018) version of testrail which does not work with php5 anymore, but needs php 7.

Another change compared with the original version is that the docker container can be run multiple times without errors, since some initialization steps were moved into the Dockerfile instead of running on each start.

# testrail

Run [TestRail](http://www.gurock.com/testrail/) in a Docker container, for testing and development.

## Prerequisites

1. Download your version of TestRail from their website, and put it in the current directory (e.g. `testrail-5.6.0.3853-ion70.zip`).
1. Have your TestRail license key ready. You will need it later.

This repository includes a minimal database dump (`testrail.sql`) that can be used as a starting point.
If you want to use your own data, you can dump your existing TestRail database server and replace `testrail.sql` with the contents.
For example:

    mysqldump testrail > testrail.sql

## Build the Image

To build the image:

    docker build -t testrail .

## Run the Container

    ./start_container.sh

## Usage

Browse to:

    http://localhost:7070/testrail/

To log in:

- Email address: `admin@admin.com`
- Password: `admin`
