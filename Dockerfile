FROM debian:buster
MAINTAINER xxaxxelxx <x@axxel.net>

RUN apt-get -qq -yy update
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get -qq -yy dist-upgrade

RUN apt-get install -q -yy mariadb-client

# clean up
RUN apt-get clean


COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]
CMD [ "bash" ]
