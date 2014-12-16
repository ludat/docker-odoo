FROM ludat/odoo-base:8.0
MAINTAINER lucas6246@gmail.com

# Set up overridable defaults
ADD https://raw.githubusercontent.com/ludat/docker-odoo/master/sources/odoo.conf /etc/odoo-default.conf
ADD http://nightly.odoo.com/8.0/nightly/src/odoo_8.0.latest.tar.gz /opt/odoo.tar.gz
RUN tar xzvf /opt/odoo.tar.gz -C /opt/ && \
    mv -v /opt/odoo-*/* /opt/odoo/ && \
    rm -v -r /opt/odoo.tar.gz /opt/odoo-*
RUN chown -R odoo:odoo /opt /etc/odoo-default.conf

# changing user is required by openerp which won't start with root
# makes the container more unlikely to be unwillingly changed in interactive mode
USER odoo

# Execution environment
WORKDIR /opt/odoo
VOLUME ["/opt/odoo", "/etc/odoo.conf", "/additional_addons"]

# Set the default entrypoint (non overridable) to run when starting the container
USER 0
ENTRYPOINT ["/bin/boot.sh"]
CMD ["help"]
# Expose the odoo ports (for linked containers)
EXPOSE 8069
ADD bin/boot.sh bin/help.txt /bin/
