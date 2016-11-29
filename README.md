# NRHS

NRHS V-Twin Performance


## Dependencies

    $ ruby -v
    ruby 2.2.3p173 (2015-08-18 revision 51636) [x86_64-linux]

    $ rails -v
    Rails 5.0.0.1


## Setup

    $ bundle install

    $ bundle exec rake db:create
    $ bundle exec rake db:migrate
    $ bundle exec rake db:setup


## Testing

    $ bundle exec rspec


## Running

    $ bundle exec rails server

Visit `http://localhost:3000`.


## Deploying

Committing new code to `master` automatically deploys new code to Heroku.  If
your new code requires database migrations, use the Heroku command line tool to
run migrations:

    $ heroku run -a nrhs rake db:migrate


## Administration

### Create Admin Account

Development:

    $ cd /path/to/project
    $ bundle exec rake nrhs:create_admin[admin@example.com,password]

Production:

    $ heroku run -a nrhs rake nrhs:create_admin[admin@example.com,password]
