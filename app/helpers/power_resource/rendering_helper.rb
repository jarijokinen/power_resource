module PowerResource
  module RenderingHelper
    # Renders collection table
    def render_collection_table(custom_attributes = nil)
      render 'collection',
        collection: collection,
        attributes: custom_attributes || resource_human_attributes,
        collection_table_classes: collection_table_classes,
        collection_table_button_classes: collection_table_button_classes
    end

    # Renders form using selected form builder
    def render_form(form_builder = 'form_for')
      fields = resource_human_attributes
      fields.map! do |arg|
        arg.to_s.sub('_id', '').to_sym
      end
      render "power_resource/builders/#{form_builder}", fields: fields
    end

    # Renders actions for a specific resource
    def render_actions_for(resource)
      render 'actions', resource: resource
    end
  end
end
