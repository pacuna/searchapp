#!/bin/bash
echo 'creating test database...'
RAILS_ENV=test rake db:create
echo 'migrating test database...'
RAILS_ENV=test rake db:migrate
echo 'running tests...'
RAILS_ENV=test rake

return_code=$?
if [[ $return_code != 0 ]] ; then
  echo -e "Tests failed."
  exit $return_code
fi

