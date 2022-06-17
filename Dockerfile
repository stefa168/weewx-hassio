#FROM alpine
#FROM arm32v7/alpine
ARG BUILD_FROM
FROM $BUILD_FROM

ENV WEEWX_HOME="/home/weewx"
ENV WEEWX_VERSION="4.8.0"
ENV ARCHIVE="weewx-${WEEWX_VERSION}.tar.gz"

WORKDIR /tmp

# Dependencies
RUN apk update
# https://stackoverflow.com/a/65555646/3560579
#RUN apk add --no-cache tar python3 py3-pip jpeg-dev zlib-dev
RUN apk add --no-cache tar python3 py3-pip py3-pillow
#RUN apk add --update --no-cache --virtual .tmp gcc libc-dev linux-headers python3-dev
#RUN pip install configobj Pillow pyserial pyusb Cheetah3 paho-mqtt
RUN pip install configobj pyserial pyusb Cheetah3 paho-mqtt
#RUN apk del .tmp

# Add link for extension installer python script
RUN ln -sf python3 /usr/bin/python

# Download Sources
# wget -O weewx-4.8.0.tar.gz https://weewx.com/downloads/released_versions/weewx-4.8.0.tar.gz
RUN wget -O "${ARCHIVE}" "https://weewx.com/downloads/released_versions/${ARCHIVE}"
RUN wget -O weewx-mqtt.zip https://github.com/matthewwall/weewx-mqtt/archive/master.zip
RUN wget -O weewx-interceptor.zip https://github.com/matthewwall/weewx-interceptor/archive/master.zip

RUN mkdir -p /home/weewx
RUN tar --extract --gzip --file "${ARCHIVE}" --directory /home/weewx --strip-components=1

WORKDIR ${WEEWX_HOME}

# Install extensions
RUN bin/wee_extension --install /tmp/weewx-mqtt.zip
RUN bin/wee_extension --install /tmp/weewx-interceptor.zip

# Create configuration folder
#RUN mkdir -p /config/weewx
#RUN cp weewx.conf /config/weewx

# Build and Install weewx
RUN python3 ./setup.py build
RUN python3 ./setup.py install

RUN rm -f weewx.conf.*

# Initialize syslogd logging location as we'll need it to read what weewx sends to it
RUN touch /var/log/messages

COPY run.sh /
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]

# syslogd & tail -f /var/log/messages & /home/weewx/bin/weewxd /config/weewx/weewx.conf

# apk add --no-cache openrc