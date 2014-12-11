#!/bin/bash
#
# This script is designed to be run inside the container
#

# fail hard and fast even on pipelines
set -eo pipefail

function help {
    set +e
    cat /bin/help.txt
    set -e
}

function login  {
    echo "Running bash"
    set +e
    if [[ ! -e $1 && $1 = "root" ]]; then
        /bin/bash
    else
        sudo su - odoo
    fi
    SERVICE_PID=$!
    set -e
}

function start {
    echo "Running odoo..."
    set +e
    if [ ! -e $1 ]; then
        echo "...with additional args: $*"
    fi
    chown odoo:odoo /etc/odoo.conf
    sudo -i -u odoo /usr/bin/python \
                    /opt/odoo/openerp-server \
                    -c /etc/odoo.conf \
                    $* &

    SERVICE_PID=$!
    set -e
}

# smart shutdown on SIGINT and SIGTERM
function on_exit() {
    kill -TERM $SERVICE_PID
    wait $SERVICE_PID 2>/dev/null
    exit 0
}
trap on_exit INT TERM

echo "Running command..."
id
pwd
for arg in "$*"
do
    $arg
done

wait