# RSpec::Hanami
**rspec-rails** is a testing framework for [hanami](http://hanamirb.org)

## Installation
Add this line to your application's Gemfile:

```ruby
group :test do
  gem 'rspec-hanami'
end
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rspec-hanami

## Supported matchers
### Controller Specs
#### `have_http_status`
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

## Also see

* [https://github.com/rspec/rspec](https://github.com/rspec/rspec)
* [https://github.com/rspec/rspec-core](https://github.com/rspec/rspec-core)
* [https://github.com/rspec/rspec-expectations](https://github.com/rspec/rspec-expectations)
* [https://github.com/rspec/rspec-mocks](https://github.com/rspec/rspec-mocks)

## Feature Requests & Bugs

See <http://github.com/davydovanton/rspec-hanami/issues>

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

