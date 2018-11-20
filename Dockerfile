FROM elixir:alpine

RUN apk update && \
    apk --no-cache --update add \
      git make g++ wget curl inotify-tools \
      # for wkhtmltopdf
      xvfb fontconfig dbus \
      libgcc libstdc++ libx11 glib libxrender libxext libintl \
      libcrypto1.0 libssl1.0 \
      ttf-dejavu ttf-droid ttf-freefont ttf-liberation ttf-ubuntu-font-family && \
      # for wkhtmltopdf end
    rm -rf /var/cache/apk/*


COPY bin/wkhtmltopdf /usr/bin

RUN chmod +x /usr/bin/wkhtmltopdf

# Wrapper for xvfb
RUN mv /usr/bin/wkhtmltopdf /usr/bin/wkhtmltopdf-origin && \
    echo $'#!/usr/bin/env sh\n\
    Xvfb :0 -screen 0 1024x768x24 -ac +extension GLX +render -noreset & \n\
    DISPLAY=:0.0 wkhtmltopdf-origin $@ \n\
    killall Xvfb\
    ' > /usr/bin/wkhtmltopdf && \
    chmod +x /usr/bin/wkhtmltopdf

RUN mix local.hex --force
  #\
 #&& mix archive.install hex phx_new 1.4.0 --force \
 #&& mix local.rebar --force

WORKDIR /app
