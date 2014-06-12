# PowerResource

Power up RESTful resources!

## Requirements

* Ruby 2.1 or greater
* Rails 4.1 or greater
* Active Record 4.1 or greater

## Installation

Add this line to your application's Gemfile:

    gem 'power_resource'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install power_resource

## Usage

### Basic Usage

Inherit your resource controllers from PowerResource::BaseController:

    class PostsController < PowerResource::BaseController
    end

### Strong Parameters

Permit **only** title and content (recommended way):

    class PostsController < PowerResource::BaseController
      def permit_attributes
        %w(title content)
      end
    end

Permit **all** attributes:

    class PostsController < PowerResource::BaseController
      def permit_attributes
        resource_attributes
      end
    end

Permit all attributes **except** id:

    class PostsController < PowerResource::BaseController
      def permit_attributes
        resource_attributes - %w(id)
      end
    end
    
Permit all **human-readable attributes** (all except id, created\_at and
updated\_at):

    class PostsController < PowerResource::BaseController
      def permit_attributes
        resource_human_attributes
      end
    end

Permit all **human-readable attributes, except** title and content:

    class PostsController < PowerResource::BaseController
      def permit_attributes
        resource_human_attributes - %w(title content)
      end
    end

Setting default behaviour can be done in ApplicationController:

    class ApplicationController < ActionController::Base
      def permit_attributes
        resource_human_attributes
      end
    end

Also, you can use [Inherited Resources
way](https://github.com/josevalim/inherited_resources#strong-parameters) way:

    class PostsController < PowerResource::BaseController
      def permitted_params
        params.permit(post: %w(title content))
      end
    end

### Helpers

Besides all [helpers from Inherited Resources
gem](https://github.com/josevalim/inherited_resources#url-helpers), next helper
methods are available:

    resource_form_path   #=> /products     when creating a new resource
                         #=> /products/1   when resource already exists

## Support

If you have any questions or issues with PowerResource, or if you like to
report a bug, please create an [issue on
GitHub](https://github.com/jarijokinen/power_resource/issues).

## License

MIT License. Copyright (c) 2013 - 2014 [Jari Jokinen](http://jarijokinen.com).
See
[LICENSE](https://github.com/jarijokinen/power_resource/blob/master/LICENSE.txt)
for further details.
