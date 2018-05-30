# Pagy Extras

This gem has been integrated in [Pagy](https://github.com/ddnexus/pagy) >= 0.8.0 and has been discontinued.

If your code still use it, please, remove the gem and convert the code considering the following:

- `Pagy.extras_root.join('whatever')` is gone. Now you can use `Pagy.root.join('pagy', 'extras', 'whatever')`
- The `pagy-extras` gem was loading all the extras. Now you require only those you use right in the initializer. For example `require 'pagy/extras/bootstrap'` _(see the [initializer_example.rb](https://github.com/ddnexus/pagy/blob/master/lib/pagy/extras/initializer_example.rb))_.
- See the new [Extras Documentation](https://ddnexus.github.io/pagy/extras) for more details
- See the pagy [CHANGELOG](https://github.com/ddnexus/pagy/blob/master/CHANGELOG.md) for breaking changes
