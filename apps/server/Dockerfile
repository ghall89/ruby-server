# Use a slim Ruby image
FROM ruby:3.2-slim

# Install build deps and common libs (adjust for DB drivers)
RUN apt-get update && apt-get install -y build-essential libssl-dev libpq-dev && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copy only Gemfile first for caching
COPY Gemfile Gemfile.lock ./
RUN gem install bundler && bundle install --jobs 4 --retry 3

# Copy app code
COPY . .

ENV RACK_ENV=production
EXPOSE 8000

CMD ["bundle", "exec", "rackup"]
