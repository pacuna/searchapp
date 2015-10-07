FROM phusion/passenger-ruby22

# Set correct environment variables.
ENV HOME /root

# Use baseimage-docker's init process.
CMD ["/sbin/my_init"]

# additional packages 
RUN apt-get update && apt-get install -y mysql-client-core-5.5

# Active nginx
RUN rm -f /etc/service/nginx/down

# Install heavy gems for adding an extra caching layer
RUN gem install nokogiri:1.6.6.2 mini_portile:0.6.2

# Install bundle of gems
WORKDIR /tmp
ADD Gemfile /tmp/
ADD Gemfile.lock /tmp/

RUN bundle install

# Copy the nginx template for configuration and preserve environment variables
RUN rm /etc/nginx/sites-enabled/default

# Add the nginx site and config
ADD webapp.conf /etc/nginx/sites-enabled/webapp.conf

# Add the rails-env configuration file
ADD rails-env.conf /etc/nginx/main.d/rails-env.conf

RUN mkdir /home/app/webapp
COPY . /home/app/webapp
RUN usermod -u 1000 app
RUN chown -R app:app /home/app/webapp
WORKDIR /home/app/webapp

RUN mkdir -p /etc/my_init.d
ADD deploy/start.sh /etc/my_init.d/start.sh

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
