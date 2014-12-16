I stole this from [xcgd](https://bitbucket.org/xcgd/odoo) and modified it to suit my needs

A dockerfile for Odoo 8.0
=========================

Arquitecture
------------

My goal is to have everything separated so it's easier to debug if something breaks ideally I'd just replace only that part. So I have three images:

* **postgres**: This image is just [the official postgres image](https://registry.hub.docker.com/_/postgres/) with some minimal customization in [run_posgres.sh](https://github.com/ludat/docker-odoo/blob/master/run_postgres.sh)
* **odoo-base**: This image is build with the [base Dockerfile](https://github.com/ludat/docker-odoo/blob/master/base/Dockerfile) and it's propouse is just to serve all the dependencies that the specific version of odoo might require, create the odoo user and **nothing more** (this image should be in the docker hub and once it runs it should **not** be touched )
* **odoo**: This image should be build by the user. It's based on odoo-base And it's job is:
    * Download necesary files (configuration files, odoo itself, etc.)
    * Add the boot.sh which serves as an init script.
    * Expose ports
    * Create volumes
    This image **won't be** in the Docker hub just for now.

Odoo version
------------

As of today I only support Odoo 8.0 and probably will never go lower than that. But if a new version comes out you should not thrust the ludat/odoo-base:latest instead use the propper version number (ludat/odoo-base:8.0)

Prerequisites
=============

postgresql
---------------

The postgres image **must** be running to start Odoo. Just execute `run_postgres.sh` and it will pull the image from docker hub if it needs to (it uses postgres:9 which should be the latest for a while).

When it runs the script does some things:
* Asigns it a name (´pg´ by default): to be linked later to the odoo container.
* Set the values for enviroment variables `POSTGRES_USER` and `POSTGRES_PASSWORD` (which default to `odoo` and `password` respectively): This are used to create a default user and password for the database which **MUST** be the same as those on the odoo.conf.
* [OPTIONALLY] Adds a non-volatile volume so your data gets stored on the hosts file system

**YOU SHOULD CHANGE THE DEFAULT PASSWORD TO SOMETHING ELSE**

The _real_ documentation can be found on [the docker page of postgres](https://registry.hub.docker.com/_/postgres/)

Build Odoo
----------

The odoo image derives from the ludat/odoo-base image (which should contain all the needed dependencies). The build process does the following things:

* Download the odoo.conf from this repo and places it as /etc/odoo-default.conf.
* Download the nightly build tar from http://nightly.odoo.com/, untar it, chown it and place it where it should be.
* Add the volumes.
* Add the boot.sh file and set it as the entrypoint
* Expose propper ports (8069 by default)

**I encourage you to customize this Dockerfile as you see fit**. You could get odoo from the git repo instead of the nightly build or not get them at all. _The sky is the limit_

Run Odoo
========

Assuming that you have your postgres container running with some name (`pg` as default) you can issue `run_odoo.sh` which will take care of the heavy lifting for you but in short it:

* Connects the port 80 on the local machine to the port 8069 on the container.
* Sets volumes: you can choose not to set any volumes the image has everything it need by default and should run fine, this is mainly for extending it without having to build the image again. There are three variables and they should be set to absolute paths on the local machine:
    * `YOUR_ODOO_FOLDER`:  Sets the odoo root folder. In case you don't want to use the nightly builds or you want to use a newer version.
    * `YOUR_ODOO_CONFIG_FILE`: Sets the odoo config file. In case you want to use a custom config file. Note that you should be carefull with this since it can make odoo behave weirdly in many ways. Also because of reasons you CAN'T edit this file once the container has launched.
    * `YOUR_ODOO_ADDITIONAL_ADDONS`: Sets an additional addons folder. Mainly for testing. Note that you must reset odoo to notice the changes and also note that this folder is synced automagically and both the container and the host can modify it.
* Links the container to `pg` which should be the postgres database.
* Names the new container `odoo`

If docker starts without issues, just open your favorite browser and point it to http://localhost/

The default admin password is `password`
