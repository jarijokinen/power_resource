module PowerResource
  class BaseController < ::ApplicationController
    inherit_resources
    defaults route_prefix: ''

    include PowerResource::BaseHelper

    def create
      create! { collection_url }
    end

    def update
      update! { collection_url }
    end

    protected

    def permit_attributes
      # Override this method in your controller:
      #
      #   class PostsController < PowerResource::BaseController
      #     def permit_attributes
      #       %w(title content)
      #     end
      #   end
      #
      # Or add default behaviour in your ApplicationController:
      #
      #   class ApplicationController < ActionController::Base
      #     def permit_attributes
      #       resource_human_attributes
      #     end
      #   end
    end

    def permitted_params
      params.permit(
        resource_name => permit_attributes
      )
    end
  end
end
