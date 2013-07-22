module PowerResource
  module BaseHelper
    # Returns humanized and localized name for a current resource model
    def resource_human_name
      resource_class.model_name.human
    end

    # Returns humanized and localized name for a specified resource class
    def resource_human_name_for(resource_class_name)
      eval("#{resource_class_name.to_s.classify}.model_name.human")
    end

    # Returns an unique title for a resource
    def resource_title
      "#{resource_human_name} #{resource.id}"
    end

    # Returns a title for a collection
    def collection_title
      I18n.t("activemodel.models.#{controller_name.singularize}.other",
        default: controller_name.humanize)
    end

    # Returns all attributes for a resource
    def resource_attributes
      resource_class.attribute_names
    end

    # Returns attributes that should be invisible for end-users
    def non_human_attributes
      %w(id updated_at created_at)
    end

    # Returns attributes for a resource without non-human attributes
    def resource_human_attributes
      human_attributes = resource_attributes - non_human_attributes
      if respond_to?("parent?")
        parent_attribute = "#{parent.class.name.underscore}_id"
        human_attributes = human_attributes - ["#{parent_attribute}"]
      end
      human_attributes
    end

    # Returns humanized and localized attribute name
    def attribute_human_name(attribute_name)
      attribute_name = attribute_name.to_s
      I18n.t("activerecord.attributes.#{controller_name.singularize}.#{attribute_name}",
        default: attribute_name.humanize)
    end

    # Returns truncated attribute value
    def attribute_value(resource, attribute_name, truncation = 50)
      value = resource.send(attribute_name).to_s.truncate(truncation)
      if attribute_name.to_s.match(/_id$/)
        model_name = attribute_name.gsub(/_id$/, "").classify
        begin
          value = eval(model_name).find(value).to_s
        rescue ActiveRecord::RecordNotFound
          value = ""
        end
      end
      value
    end

    # Returns a text based on action and resource names
    #
    # Example:
    #
    #   resource_action(:new)
    #     # => "New Product"
    def resource_action(action_name)
      I18n.t("power_resource.resource_actions.#{action_name}",
             resource_name: resource_human_name,
             default: "#{action_name.to_s.titleize} #{resource_human_name}")
    end

    # Returns a link for a resource
    #
    # Examples:
    #
    #   resource_link(:new) 
    #     # => <a href="/products/new">New Product</a>
    #   resource_link(:edit) 
    #     # => <a href="/products/1/edit">Edit Product</a>
    #   resource_link(:edit, row)
    #     # => <a href="/products/1/edit">Edit</a>
    #   resource_link(:edit, text: "Make changes") 
    #     # => <a href="/products/1/edit">Make changes</a>
    def resource_link(action_name)
      text ||= resource_action(action_name)

      eval("resource_link_for_#{action_name.to_s}(text)")

      case action_name.to_sym
      when :new
        link_to(text, new_resource_path)
      when :edit
        link_to(text, edit_resource_path(resource))
      when :delete
        link_to
      end
    end

    # Returns form path for a resource
    def resource_form_path
      resource.new_record? ? collection_path : resource_path
    end

    # Renders form using selected form builder
    def render_form(form_builder = "formtastic")
      fields = resource_human_attributes
      fields.map! do |arg|
        arg.to_s.sub("_id", "").to_sym
      end
      render "power_resource/builders/#{form_builder}", fields: fields
    end

    # Renders collection table
    def render_collection_table(custom_attributes = nil)
      render "collection",
        collection: collection,
        attributes: custom_attributes || resource_human_attributes
    end

    # Renders action links for a resource
    def render_actions_for(resource)
      render "actions", resource: resource
    end

    private

    def resource_link_for_index(text)
      link_to(text, collection_path)
    end

    def resource_link_for_show(text)
      link_to(text, resource_path(resource))
    end

    def resource_link_for_new(text)
      link_to(text, new_resource_path)
    end

    def resource_link_for_edit(text)
      link_to(text, edit_resource_path(resource))
    end
  end
end
