# Elixir + Phoenix

FROM elixir:1.7

# Install debian packages
# Install node
RUN curl -sL https://deb.nodesource.com/setup_9.x -o nodesource_setup.sh \
 && bash nodesource_setup.sh \
 && apt-get install nodejs \
 && apt-get install --yes build-essential inotify-tools postgresql-client \
 && apt-get autoremove && apt-get autoclean \
 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install Phoenix packages
RUN mix local.hex --force \
 && mix local.rebar --force \
 && mix archive.install --force https://github.com/phoenixframework/archives/raw/master/phx_new.ez

WORKDIR /app
EXPOSE 4000
