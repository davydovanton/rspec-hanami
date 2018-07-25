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

### Capybara
Check your `spec/features_helper.rb` and `spec/support/Capybara.rb` files. If you find something like this:

```ruby
Capybara.app = Hanami::Container.new
# or
Capybara.app = Hanami::App.new
```

Please change this line to:
```ruby
Capybara.app = ::Hanami::Container.new
# or
Capybara.app = ::Hanami::App.new
```

For more information see [this issue](https://github.com/davydovanton/rspec-hanami/issues/1)

## Supported matchers
### Request helpers
You can use familiar request helpers like `#get`, `#post`, etc.
These methods make full hanami app request and return env (array with 3 elements).

For using these helpers include `RSpec::Hanami::RequestHelpers` to your `spec_helper.rb` file:

```ruby
config.include RSpec::Hanami::RequestHelpers
```

After that you can call any method:
```ruby
it { expect(get('/')).to be_success }
it { expect(post('/tasks')).to redirect_to('/tasks') }
```

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

#### `match_in_body`
Passes if `body` matches with argument

``` ruby
response = action.call(params)
expect(response).to match_in_body('Tittle')
expect(response).to match_in_body(/Tittle\s\d+/)
```

### Views Specs
#### `have_action`
Passes if form object has an action

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

### Entity specs
Passes if argument type has a matching with type.
You can use `Hanami::Entity::Types` for compare.

#### `have_attribute`
Passes if `:name` has `Types::String` type:

``` ruby
it { expect(User).to have_attribute(:name, Types::String) }
```

#### `have_attributes`
Passes if `:name` has `Types::String` type and `:age` has `Types::Int` type:

``` ruby
it { expect(User).to have_attributes(name: Types::String, age: Types::Int) }
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

