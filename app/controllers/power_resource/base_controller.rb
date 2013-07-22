module PowerResource
  class BaseController < ::ApplicationController
    inherit_resources
    defaults route_prefix: ''

    def create
      create! { collection_url }
    end

    def update
      update! { collection_url }
    end

    protected

    def resource_name
      controller_name.tableize.singularize.to_sym
    end

    def permitted_params
      params.permit(
        resource_name => resource_class.attribute_names - denied_params
      )
    end

    def denied_params
      %w(id created_at updated_at)
    end
  end
end
