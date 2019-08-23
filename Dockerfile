# Copyright 2015 Google Inc. All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
#you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
#
# nginx-ssl-proxy
#
# VERSION   0.0.1

FROM nginx:alpine

MAINTAINER Evan Brown <evanbrown@google.com>

RUN rm /etc/nginx/conf.d/*.conf

RUN mkdir -p /etc/nginx/extra-conf.d

WORKDIR /usr/src

COPY start.sh /usr/src/
COPY nginx/nginx.conf /etc/nginx/
COPY nginx/proxy*.conf /usr/src/
COPY nginx/extra/*.conf /etc/nginx/extra-conf.d/

RUN apk add openssl
RUN apk add socat
RUN wget -O -  https://get.acme.sh | sh

ENTRYPOINT ./start.sh
