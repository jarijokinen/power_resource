module PowerResource
  module ConfigurationHelper
    def collection_table_classes
      PowerResource::Configuration.collection_table_classes.join(' ')
    end

    def collection_table_button_classes
      PowerResource::Configuration.collection_table_button_classes.join(' ')
    end
  end
end
