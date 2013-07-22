# PowerResource

Power up your RESTful resources!

ALPHA STAGE, DO NOT USE IN PRODUCTION!

## Requirements

* Ruby 2.0.0 or greater
* Rails 4.0.0 or greater

## Installation

Add this line to your application's Gemfile:

    gem 'power_resource'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install power_resource

## Usage

Inherit your resource controllers from PowerResource::BaseController:

    class ProductsController < PowerResource::BaseController
    end

## Helpers

Besides all [helpers from Inherited Resources gem](https://github.com/josevalim/inherited_resources#url-helpers), next helper methods are available:

    resource_form_path   #=> /products     when creating a new resource
                         #=> /products/1   when resource already exists

## Support

If you have any questions or issues with PowerResource, or if you like to report a bug, please create an [issue on GitHub](https://github.com/jarijokinen/power_resource/issues).

## License

MIT License. Copyright (c) 2013 [Jari Jokinen](http://jarijokinen.com). See [LICENSE](https://github.com/jarijokinen/power_resource/blob/master/LICENSE.txt) for further details.
