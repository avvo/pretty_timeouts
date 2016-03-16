# PrettyTimeouts

Makes your faraday timeouts prettier so the errors are understandable. Because
timeouts happen, and you shouldn't get errors like "too many connection resets
(due to Net::ReadTimeout - Net::ReadTimeout) after 0 requests on 32015200, last
used 1457942950.263436 seconds ago".

Instead, the pretty timeout for a service named "myservice" with a timeout of
2s will read:

```
myservice timeout of 2s reached attempting to connect to http://localhost:4321/api/v1/books.json
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'pretty_timeouts'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install pretty_timeouts

## Usage

In your faraday connection setup, just include the
`PrettyTimeouts::Middleware`:

```ruby
Faraday.new do |conn|
  conn.use HttpClient::PrettyTimeoutsMiddleware, name
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run
`rake spec` to run the tests. You can also run `bin/console` for an interactive
prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To
release a new version, update the version number in `version.rb`, and then run
`bundle exec rake release`, which will create a git tag for the version, push
git commits and tags, and push the `.gem` file to
[rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at
https://github.com/avvo/pretty_timeouts.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
