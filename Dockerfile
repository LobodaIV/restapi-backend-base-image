FROM ubuntu:trusty
MAINTAINER Igor Loboda

#prevent dpkg errors
ENV TERM=xterm-256color

#Install Python runtime
RUN apt-get update && \
    apt-get install -y \
    -o APT::Install-Recommended=false -o APT::Install-Suggests=false \
    python python-virtualenv libpython2.7 python-mysqldb

#Create virtual environment
#Upgrade PIP in virtual env.
RUN virtualenv /appenv && \
    . /appenv/bin/activate && \
    pip install pip --upgrade

#Add entry point
ADD scripts/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

#For convenient removing of dangling images
LABEL application=todobackend
