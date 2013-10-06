module PowerResource
  module BaseHelper
    # Returns a name for a current resource
    def resource_name
      resource_class.to_s.tableize.singularize
    end
    
    # Returns humanized and localized name for a current resource
    def resource_human_name
      resource_class.model_name.human
    end
    
    # Returns humanized and localized name for a specific resource
    def resource_human_name_for(resource_class_name, count = 1)
      class_name = resource_class_name.to_s.classify
      eval(class_name).model_name.human(count: count)
    end

    # Returns an unique title for a current resource
    def resource_title(options = {})
      I18n.t("power_resource.titles.#{resource_name}.resource",
        { default: "#{resource_human_name} #{resource.id}" }.merge(options) )
    end

    # Returns all attributes for a resource
    def resource_attributes
      resource_class.attribute_names
    end
    
    # Returns attributes that should be invisible for end-users
    def resource_non_human_attributes
      %w(id created_at updated_at)
    end
    
    # Returns attributes for a resource without non-human attributes
    def resource_human_attributes
      human_attributes = resource_attributes - resource_non_human_attributes

      # If resource has a belongs_to relationship, remove reference attribute
      if respond_to?('parent?')
        parent_attribute = "#{parent.class.name.underscore}_id"
        human_attributes = human_attributes - [parent_attribute]
      end

      human_attributes
    end

    # Returns humanized and localized attribute name
    def resource_attribute_human_name_for(attribute_name)
      attribute_name = attribute_name.to_s
      I18n.t("activerecord.attributes.#{resource_name}.#{attribute_name}",
        default: attribute_name.humanize)
    end

    # Returns preformatted attribute value of a specific resource
    def attribute_value_for(resource, attribute_name, truncation = 50)
      value = resource.send(attribute_name).to_s.truncate(truncation)
      if attribute_name.to_s.match(/_id$/)
        model_name = attribute_name.gsub(/_id$/, '').classify
        begin
          value = eval(model_name).find(value).to_s
        rescue ActiveRecord::RecordNotFound
          value = ""
        end
      end
      value
    end
    
    # Returns a form path for a resource
    def resource_form_path
      resource.new_record? ? collection_path : resource_path
    end

    # Returns associations for a resource
    def resource_associations(association_type)
      resource_class.reflect_on_all_associations(association_type).map(&:name)
    end
    
    # Returns association links for a resource
    def resource_association_links_for(resource, options = {})
      output = Array.new
      resource_associations(:has_many).each do |association|
        text = resource_human_name_for(association, 2)
        if controller_path.include?('/')
          namespace = controller.class.parent.name.underscore
          path = [namespace, resource, association.to_s.tableize]
        else
          path = [resource, association.to_s.tableize]
        end
        options.merge!(class: collection_table_button_classes)
        output << link_to(text, path, options)
      end
      output.join(' ').html_safe
    end
  end
end
