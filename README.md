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

to run winker_ai server

    winker_ai_start

This starts up a sinatra server that listens on port 4567 for the /command?q=string and parses it for Winker commands.

## Contributing

1. Fork it ( https://github.com/[my-github-username]/AmazonEchoJS/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
