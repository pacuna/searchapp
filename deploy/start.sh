#!/bin/sh

if [ "$PASSENGER_APP_ENV" = "production" ]; then
    RAILS_ENV=production rake db:migrate 
    RAILS_ENV=production rake assets:precompile --trace 
    RAILS_ENV=production bundle exec rake environment elasticsearch:import:model CLASS='Article' FORCE='y' BATCH=100
else
    rm -rf public/assets
fi
