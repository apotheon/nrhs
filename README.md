# NRHS

NRHS V-Twin Performance


## Dependencies

The recommended means of meeting dependency requirements is via rbenv.

    $ ruby -v
    ruby 2.3.1p112 (2016-04-26 revision 54768) [x86_64-linux]

    $ rails -v
    Rails 5.0.0.1


## Setup

    $ bundle install

    $ bundle exec rake db:create
    $ bundle exec rake db:migrate
    $ bundle exec rake db:setup


## Development Environment

For general development purposes, you can run a server and get some nice
automatic test-runner facilities by running guard in a separate window while
editing code:

    $ bundle exec guard

You can also run tests and a local server instance separately:

### Server

    $ bundle exec rails server

### Testing

    $ bundle exec rspec

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
