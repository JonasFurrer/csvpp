# CSV++

CSV++ takes a `<DELIMITER>` separated input file and a JSON format specification
and turns it into Ruby Objects. See `test/sample_inputs/simple.txt` and
`test/sample_formats/simple.json` for example.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'csvpp'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install csvpp

## Usage

```ruby
CSVPP.parse(
  'test/sample_inputs/simple.txt',
  format: 'test/sample_formats/simple.json'
) # => [{"v1"=>34, "line_number"=>1, "v2"=>"foobar"}, {"v1"=>99, "line_number"=>2, "v2"=>"hi  there"}]
```

## Features

- [x] Parse input that conforms to a format specified in a JSON file
- [x] Type conversions
- [ ] More validation options
- [ ] JSON format file validator
- [ ] Input file generator (useful for tests)
- [ ] Report generator (as a single source of truth)

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run
`rake test` to run the tests. You can also run `bin/console` for an interactive
prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To
release a new version, update the version number in `version.rb`, and then run
`bundle exec rake release`, which will create a git tag for the version, push
git commits and tags, and push the `.gem` file to
[rubygems.org](https://rubygems.org).

## License

The gem is available as open source under the terms of the [MIT
License](https://opensource.org/licenses/MIT).
