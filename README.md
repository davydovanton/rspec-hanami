# RSpec::Hanami

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/rspec/hanami`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rspec-hanami'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rspec-hanami

## Supported matchers
### `have_http_status`
Passes if `response` has a matching HTTP status code.

The following symbolic status codes are allowed:
  - `:error`
  - `:missing`
  - `:redirect`
  - `:success`
  - `Rack::Utils::SYMBOL_TO_STATUS_CODE`

``` ruby
response = action.call(params)
expect(response).to have_http_status(404)
expect(response).to have_http_status(:created)
expect(response).to have_http_status(:success)
expect(response).to have_http_status(:error)
expect(response).to have_http_status(:missing)
expect(response).to have_http_status(:redirect)
```

## TODO

- [ ] `expect(action).to be_success`
- [ ] `expect(response).to render_template("index")`
- [ ] `expect(response).to redirect_to(widgets_path)`

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

