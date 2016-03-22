[![Build Status](https://travis-ci.org/leksster/SimpleCart-engine.svg?branch=master)](https://travis-ci.org/leksster/SimpleCart-engine)

## SimpleCart

### Installation:

```ruby
gem 'simple_cart'
```

### Usage:

##### Your model should contain fields:
  - name (sting)
  - price (decimal)
  - qty (integer)

##### After you install SimpleCart and add it to your Gemfile, you need to run the generator:
```ruby
rails generate simple_cart:install
```

##### Run migrations task
```ruby
rake db:migrate
```

##### You can manage delivery services in the database using rake tasks. You need to create one in order to use checkout procedure properly.
```ruby
rake simple_cart:create_delivery [NAME] [COSTS]
rake simple_cart:delete_delivery [NAME]
rake simple_cart:delete_all
```

##### Use view helper method to add 'buy' button with required object:
```html
<%= add_to_cart(object) %>
```

##### If you want to customize views
```ruby
rails generate simple_cart:views
```
:trollface:
