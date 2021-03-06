FROM pointslope/clojure:lein-2.5.3

MAINTAINER Christian Romney "cromney@pointslope.com"

ENV DATOMIC_VERSION 0.9.5350
ENV DATOMIC_SRC datomic-pro-$DATOMIC_VERSION
ENV DATOMIC_HOME /opt/datomic-pro-$DATOMIC_VERSION
ENV DATOMIC_DATA $DATOMIC_HOME/data

# Datomic Pro Starter as easy as 1-2-3
# 1. Create a .credentials file containing user:pass
# for downloading from my.datomic.com
# ONBUILD ADD .credentials /tmp/.credentials

# 2. Make sure to have a config/ folder in the same folder as your
# Dockerfile containing the transactor property file you wish to use
# https://my.datomic.com/downloads/pro/0.9.5350
# ONBUILD RUN curl -u $(cat /tmp/.credentials) -SL https://my.datomic.com/downloads/pro/$DATOMIC_VERSION/ -o /tmp/datomic.zip \
#   && unzip /tmp/datomic.zip -d /opt \
#   && rm -f /tmp/datomic.zip

COPY $DATOMIC_SRC $DATOMIC_HOME

# ONBUILD ADD config $DATOMIC_HOME/config

WORKDIR $DATOMIC_HOME

ENTRYPOINT ["bin/transactor"]

# 3. Provide a CMD argument with the relative path to the
# transactor.properties file it will supplement the ENTRYPOINT
VOLUME $DATOMIC_DATA

EXPOSE 4334 4335 4336
