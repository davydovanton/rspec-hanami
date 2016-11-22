# RSpec::Hanami

[![Build Status](https://travis-ci.org/davydovanton/rspec-hanami.svg?branch=master)](https://travis-ci.org/davydovanton/rspec-hanami) [![Coverage Status](https://coveralls.io/repos/github/davydovanton/rspec-hanami/badge.svg?branch=master)](https://coveralls.io/github/davydovanton/rspec-hanami?branch=master)

**rspec-hanami** is a testing framework for [hanami](http://hanamirb.org)

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

After that require gem to `spec_helper.rb` and include matchers to rspec:

```ruby
require 'rspec/hanami'

RSpec.configure do |config|
  config.include RSpec::Hanami::Matchers

  # ...
end
```

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

#### `be_success`
Passes if `response` has a not 4xx and 5xx error code.

``` ruby
response = action.call(params)
expect(response).to be_success
````

#### `redirect_to`
Passes if `response` has a redirect to special url

``` ruby
response = action.call(params)
expect(response).to redirect_to('site.com')
```

### Views Specs
#### `have_action`
Passes if form object has a action

``` ruby
expect(view.form).to     have_action('/users')
expect(view.form).to_not have_action('/books')
```

#### `have_method`
Passes if form object has a method

``` ruby
expect(view.form).to     have_method('POST')
expect(view.form).to     have_method(:post)
expect(view.form).to_not have_method(:put)
```

#### `have_field`
Passes if form object has a field with wanted params

``` ruby
expect(view.form).to have_field(node: input, type: 'text', id: 'user-first-name')
```

## Also see

* <https://github.com/rspec/rspec>
* <https://github.com/rspec/rspec-core>
* <https://github.com/rspec/rspec-expectations>
* <https://github.com/rspec/rspec-mocks>

## Feature Requests & Bugs

See <http://github.com/davydovanton/rspec-hanami/issues>

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

