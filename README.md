# WinkerAI

WinkerAI is an AI approach to controlling Wink hub components by making use of the Winker gem and Wink API

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'WinkerAI'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install winker_ai

## Associated Gems

    Winker
    AmazonEchoJS

## Usage

This gem was intended to be used with my AmazonEchoJS gem, but I made it modular enough that any text input should work.

First you will need to configure some ENV variables

    ENV['WINK_CLIENT_ID']
    ENV['WINK_CLIENT_SECRET']
    ENV['WINK_ACCESS_TOKEN']
    ENV['WINK_REFRESH_TOKEN']
    ENV['WINK_USERNAME']
    ENV['WINK_PASSWORD']
    ENV['WINK_ENDPOINT']
    ENV['ECHO_SERVER_PORT'] #port that sinatra will run on
    
    here is an example of my ~/.bash_profile
    
    export WINK_CLIENT_ID="*******"
    export WINK_CLIENT_SECRET="*******"
    export WINK_ACCESS_TOKEN="********"
    export WINK_REFRESH_TOKEN="********"
    export WINK_USERNAME="email@domain.com"
    export WINK_PASSWORD="*******"
    export WINK_ENDPOINT="https://winkapi.quirky.com"

    export ECHO_EMAIL="email@domain.com"
    export ECHO_PASSWORD="**********"
    export ECHO_SERVER_PORT="4567"
    export ECHO_SERVER="http://localhost:$ECHO_SERVER_PORT/command"

to run winker_ai server

    winker_ai_start

This starts up a sinatra server that listens on port 4567 for the /command?q=string and parses it for Winker commands.

## Contributing

1. Fork it ( https://github.com/[my-github-username]/AmazonEchoJS/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
