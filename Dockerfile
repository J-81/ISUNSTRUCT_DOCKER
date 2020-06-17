FROM ubuntu:18.04

ENV HOMEDIR /home/appuser
ENV INSTALLDIR /usr/local
RUN useradd --create-home appuser
WORKDIR ${INSTALLDIR}

RUN apt-get update

# build
RUN buildDeps='wget build-essential' \
	&& apt-get install -y --no-install-recommends $buildDeps \
	&& wget http://bioinfo.protres.ru/IsUnstruct/IsUnstruct_2.02.tar.gz \
	&& tar xzf IsUnstruct_2.02.tar.gz && rm IsUnstruct_2.02.tar.gz \
	&& make \
	&& apt-get purge -y --auto-remove $buildDeps

ENV PATH $INSTALLDIR:$PATH

USER appuser
WORKDIR ${HOMEDIR}


ENTRYPOINT ["IsUnstruct"]

