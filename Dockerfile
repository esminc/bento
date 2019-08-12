FROM ruby:2.5.5-slim

# NOTE: Some packages such as postgresql-client expect that these directories exist for sure even though slim images do not have them
RUN bash -c "mkdir -p /usr/share/man/man{1..8}" \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
    make gcc g++ libxml2-dev patch postgresql-client libpq-dev curl gnupg2 \
    && rm -rf /var/lib/apt/lists/* \
    && bash -c "rm -rf /usr/share/man/man{1..8}/*"
RUN gem install bundler

COPY . /bento
WORKDIR /bento

RUN bundle install
