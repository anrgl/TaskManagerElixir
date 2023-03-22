FROM elixir:1.14.2-slim

RUN apt-get update -y \
    && apt-get install -y build-essential git inotify-tools libstdc++6 openssl libncurses5 locales \
    && apt-get clean \
    && rm -f /var/lib/apt/lists/*_*

RUN sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen && locale-gen

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

WORKDIR "/app"
RUN chown nobody /app

RUN mix local.hex --force \
    && mix local.rebar --force

ARG ENV=dev
ENV MIX_ENV=${ENV}

COPY mix.exs mix.lock ./
RUN mix deps.get
RUN mkdir config

COPY config config
RUN mix deps.compile

COPY priv priv
COPY lib lib

RUN mix compile

ADD . /app

EXPOSE 4000
CMD mix phx.server
