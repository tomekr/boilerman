# Boilerman

Boilerman is a Rails engine that helps in assessing security of your authentication
and authorization logic.

Currently supports Rails versions 3.2 and greater.

## What it looks like

![Boilerman Screenshot](https://raw.github.com/tomekr/boilerman/master/screenshots/boilerman_screenshot.png)

## Features

Tracked at https://www.pivotaltracker.com/n/projects/1281714

## Installation and Usage

1. Add `gem "boilerman"` to your Gemfile
1. Run `bundle install`
1. Run `rails generate boilerman:install`
1. Start your application.
1. Navigate to `http://localhost:3000/boilerman`

## Console Usage

### Configurable Filters:

The currently implemented filters follow:

~~~
controller_filters
with_filters
without_filters
ignore_filters
ignore_actions
~~~

Within a Rails console, you can use the following syntax:

~~~
➜  railsgoat git:(master) ✗ rails c
Loading development environment (Rails 4.2.2)
[1] pry(main)> Boilerman::Actions.get_action_hash
=> {SessionsController=>
  {"new"=>
    ["verify_authenticity_token",
     "set_xhr_redirected_to",
     "set_request_method_cookie",
     "create_analytic",
     "mailer_options"]
     ...
~~~

Filters can be applied by passing in filter strings into the appropriate
hash value

~~~
[2] pry(main)> Boilerman::Actions.get_action_hash({ controller_filters: ["API"]})
=> {Api::V1::UsersController=>
  {"index"=>
    ["verify_authenticity_token",
     "set_xhr_redirected_to",
     "set_request_method_cookie",
     "has_info",
     "create_analytic",
     "mailer_options",
     "valid_api_token",
     "extrapolate_user"]
~~~

### Force loading boilerman into a Rails console

If you have access to a Rails console but for one reason or another you
can not modify the Gemfile of the application, you can force load
boilerman's lib path into the $LOAD_PATH variable. First you will need
the boilerman lib path. This could be the path you downloaded the source
to or the path of the gem when using `gem install boilerman` (e.g.
/Users/user1/.rvm/gems/ruby-2.2.1/gems/boilerman-0.1.0/lib)

When in Rails console, add the path to the $LOAD_PATH array:

~~~
➜  railsgoat git:(master) ✗ rails c
Loading development environment (Rails 4.2.2)
[1] pry(main)> $LOAD_PATH << "/Users/kamaji/.rvm/gems/ruby-2.2.1/gems/boilerman-0.1.0/lib"
~~~

After adding boilerman's lib path, you can now require it in the rails
console and use it's methods. Note, this will not give you access to the
engine and `/boilerman` path.

~~~
[3] pry(main)> require 'boilerman'
WARNING: You're probably side loading boilerman into a console.
          Note that you will only have console access to Boilerman and will be
          unable to access it via the /boilerman path
=> true
[4] pry(main)>
~~~

This project uses the MIT-LICENSE.
