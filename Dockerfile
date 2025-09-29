# syntax=docker/dockerfile:1
FROM ruby:3.3.6-slim

# system deps
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y \
      build-essential curl git libpq-dev node-gyp pkg-config python-is-python3 && \
    rm -rf /var/lib/apt/lists/*

# Node + Yarn (classic) – simple & pinned
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install --no-install-recommends -y nodejs && \
    npm install -g yarn@1.22.22 && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Install Ruby deps first for caching
COPY Gemfile Gemfile.lock ./
RUN bundle config set without 'development test' && \
    bundle install && \
    rm -rf ~/.bundle /usr/local/bundle/cache

# JS deps (if using esbuild / tailwind)
COPY package.json yarn.lock ./
RUN yarn install --immutable || yarn install

# Copy the app
COPY . .

# Precompile assets at build-time (needs SECRET_KEY_BASE, dummy is fine)
ENV RAILS_ENV=production \
    RAILS_SERVE_STATIC_FILES=1 \
    RAILS_LOG_TO_STDOUT=1
RUN SECRET_KEY_BASE=dummy bundle exec rails assets:precompile

# Non-root user
RUN groupadd --system --gid 1000 rails && \
    useradd rails --uid 1000 --gid 1000 --create-home --shell /bin/bash && \
    chown -R rails:rails /app
USER rails

# Start script: boot puma bound to $PORT (no database)
CMD bundle exec puma -C config/puma.rb