FROM debian:latest AS build-env

RUN apt-get update
RUN apt-get install -y curl git wget unzip libgconf-2-4 gdb libstdc++6 libglu1-mesa fonts-droid-fallback\
 lib32stdc++6 python3
RUN apt-get clean

RUN git clone https://github.com/flutter/flutter.git /usr/local/flutter

RUN /usr/local/flutter/bin/flutter doctor -v

ENV PATH /usr/local/flutter/bin:/usr/local/flutter/bin/cache/dart-sdk/bin:$PATH

EXPOSE 8081
RUN flutter channel master
RUN flutter upgrade
RUN flutter config --enable-web

RUN mkdir /usr/local/flutter_web_app
WORKDIR /usr/local/flutter_web_app
COPY . .
RUN /usr/local/flutter/bin/flutter build web