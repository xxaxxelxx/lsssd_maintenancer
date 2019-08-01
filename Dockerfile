FROM debian:buster
MAINTAINER xxaxxelxx <x@axxel.net>

RUN apt-get -qq -yy update
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get -qq -yy dist-upgrade

RUN apt-get install -q -yy mariadb-client
RUN apt-get install -q -yy mc

# clean up
RUN apt-get clean

COPY maintain_db.sh /maintain_db.sh

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]
#CMD [ "exit" ]
