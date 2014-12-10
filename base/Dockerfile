FROM python:2
MAINTAINER lucas6246@gmail.com

RUN export LANG=en_US.UTF-8 \
 && apt-get update && apt-get install -y --allow-unauthenticated \
        sudo \
        adduser \
        python-dateutil \
        python-decorator \
        python-docutils \
        python-feedparser \
        python-imaging \
        python-jinja2 \
        python-ldap \
        python-libxslt1 \
        python-lxml \
        python-mako \
        python-mock \
        python-openid \
        python-passlib \
        python-psutil \
        python-psycopg2 \
        python-pybabel \
        python-pychart \
        python-pydot \
        python-pyparsing \
        python-pypdf \
        python-reportlab \
        python-requests \
        python-simplejson \
        python-tz \
        python-unittest2 \
        python-vatnumber \
        python-vobject \
        python-werkzeug \
        python-xlwt \
        python-yaml \
        antiword \
        graphviz \
        ghostscript \
        python-gevent \
        poppler-utils

# create the odoo user
RUN adduser --home=/opt/odoo --disabled-password --gecos "" --shell=/bin/bash odoo
