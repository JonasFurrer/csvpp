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

```
$ bundle
```

Or install it yourself as:

```
$ gem install csvpp
```

## Usage

```ruby
CSVPP.parse(
  input: 'test/sample_inputs/simple.txt',
  format: 'test/sample_formats/simple.json'
) # => [{"v1"=>34, "line_number"=>1, "v2"=>"foobar"}, {"v1"=>99, "line_number"=>2, "v2"=>"hi  there"}]
```

### CLI

CSV++ comes with a CLI. To print a JSON representation of an input file, pass a
file argument and provide a format specification file with `-f`, e.g.:

```
$ csvpp test/sample_inputs/simple.txt -f test/sample_formats/simple.json

{
    "vars": [
        {
            "line_number": 1,
            "v1": 34,
            "v2": "foobar",
            "v3": 1.1,
            "v4": false
        },
        {
            "line_number": 2,
            "v1": 99,
            "v2": "hi  there",
            "v3": 2.2,
            "v4": true
        },
        {
            "line_number": 3,
            "v1": null,
            "v2": "Missing",
            "v3": null,
            "v4": true
        }
    ]
}
```

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
