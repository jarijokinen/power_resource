module PowerResource
  module CollectionHelper
    # Returns a name for a current collection
    def collection_name
      resource_name.tableize
    end

    # Returns humanized and localized name for a current collection
    def collection_human_name
      I18n.t("activerecord.models.#{resource_name}.other",
        default: collection_name.humanize)
    end
    
    # Returns a title for a current collection
    def collection_title(options = {})
      I18n.t("power_resource.titles.#{resource_name}.collection",
        { default: "#{collection_human_name}" }.merge(options) )
    end
  end
end
