## SimpleCart

### Installation:

```ruby
gem 'simple_cart'
```

### Usage:

Create or update your model with fields:
  - name (sting)
  - price (decimal)
  - qty (integer)

Add to your route.rb file
```ruby
mount SimpleCart::Engine => "/simple_cart"
```
Run SimpleCart migrations
```ruby
rake simple_cart:install:migrations
rake db:migrate
```
You can manage delivery companies in the database using rake tasks. You need to create one in order to use checkout procedure properly.
```ruby
rake simple_cart:create_delivery [NAME] [COSTS]
rake simple_cart:delete_delivery [NAME]
rake simple_cart:delete_all
```

Use view helper method to add 'buy' button with required object:
```html
<%= add_to_cart(object) %>
```
:trollface:
