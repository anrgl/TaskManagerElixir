ARG BUILDER_IMAGE="hexpm/elixir:1.14.2-erlang-25.1.2-debian-bullseye-20221004-slim"
ARG RUNNER_IMAGE="debian:bullseye-20221004-slim"

#
# BASE
#
FROM ${BUILDER_IMAGE} as base

RUN apt-get update -y \
    && apt-get install -y build-essential git inotify-tools \
    && apt-get clean && rm -f /var/lib/apt/lists/*_*

WORKDIR /app

RUN mix local.hex --force && \
    mix local.rebar --force

ARG ENV=prod
ENV MIX_ENV=${ENV}

COPY mix.exs mix.lock ./
RUN mix deps.get
RUN mkdir config

COPY config config
RUN mix deps.compile

COPY priv priv

COPY lib lib

RUN mix phx.swagger.generate

RUN mix phx.digest

RUN mix compile

COPY rel rel

ADD . /app

EXPOSE 4000
CMD mix phx.server

#
# BUILDER
#
FROM base as builder

RUN mix release

#
# DELIVERABLE
#
FROM ${RUNNER_IMAGE} as deliverable 

RUN apt-get update -y \
    && apt-get install -y libstdc++6 openssl libncurses5 locales \
    && apt-get clean && rm -f /var/lib/apt/lists/*_*

RUN sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen && locale-gen

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

WORKDIR "/app"
RUN chown nobody /app

COPY --from=builder --chown=nobody:root /app/_build/*/rel/task_manager ./

USER nobody

CMD ["/app/bin/server"]