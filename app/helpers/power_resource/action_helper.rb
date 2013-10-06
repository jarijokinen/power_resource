module PowerResource
  module ActionHelper
    # Returns humanized name for an action
    #
    # Customization using I18n API:
    #
    #   power_resource:
    #     actions:
    #       new: 'New %{resource_name}'
    #       edit: 'Edit %{resource_name}'
    #       index: '%{collection_name}'
    #
    # Variables available in I18n:
    #
    #   resource_name            # => Post
    #   downcased_resource_name  # => post
    #   collection_name          # => Posts
    #
    # Examples:
    #
    #   resource_action_human_name(:new)
    #     # => New Post
    #   resource_action_human_name(:edit)
    #     # => Edit Post
    #   resource_action_human_name(:duplicate)
    #     # => Duplicate Post
    #   resource_action_human_name(:index)
    #     # => Posts
    #
    def resource_action_human_name(action_name, options = {})
      I18n.t("power_resource.resource_actions.#{action_name.to_s}",
        { 
          resource_name: resource_human_name,
          downcased_resource_name: resource_human_name.downcase,
          collection_name: collection_human_name,
          default: (action_name == :index ? collection_human_name :
                    "#{action_name.to_s.humanize} #{resource_human_name}")
        }.merge(options))
    end
    
    # Returns a title for a current resource based on an action
    #
    # Customization using I18n API:
    #
    #   power_resource:
    #     titles:
    #       post:
    #         new: 'New %{resource_name}'
    #         edit: 'Edit %{resource_name}'
    #         delete: 'Delete %{downcased_resource_name}'
    #         index: '%{collection_name}'
    #
    # Variables available in I18n:
    #
    #   resource_name            # => Post
    #   downcased_resource_name  # => post
    #   collection_name          # => Posts
    #
    # Examples:
    #
    #   resource_action_title(:new)
    #     # => New Post
    #   resource_action_title(:edit)
    #     # => Edit Post
    #   resource_action_title(:duplicate)
    #     # => Duplicate Post
    #   resource_action_title(:index)
    #     # => Posts
    #
    def resource_action_title(action_name, options = {})
      I18n.t("power_resource.titles.#{resource_name}.#{action_name.to_s}", 
        { 
          resource_name: resource_human_name,
          downcased_resource_name: resource_human_name.downcase,
          collection_name: collection_human_name,
          default: resource_action_human_name(action_name, options)
        }.merge(options))
    end

    # Returns a link for a current resource based on an action
    #
    # Customization using I18n API:
    #
    #   power_resource:
    #     links:
    #       post:
    #         new: 'New %{resource_name}'
    #         edit: 'Edit'
    #         index: '%{collection_name}'
    #
    # Variables available in I18n:
    #
    #   resource_name            # => Post
    #   downcased_resource_name  # => post
    #   collection_name          # => Posts
    #
    # Examples:
    #
    #   resource_link_to(:new)
    #     # => <a href="/posts/new">New Post</a>
    #   resource_link_to(:edit, resource)
    #     # => <a href="/posts/1/edit">Edit</a>
    #   resource_link_to(:index)
    #     # => <a href="/posts/">Posts</a>
    #
    def resource_link_to(action_name, resource_instance = nil)
      if resource_instance
        human_name = resource_human_name_for(resource_instance.class.name)
      end

      case action_name
      when :show, :edit, :delete
        default_text = I18n.t("power_resource.actions.#{action_name.to_s}", 
          default: action_name.to_s.humanize)
      else
        default_text = resource_action_human_name(action_name)
      end

      text = I18n.t("power_resource.links.#{resource_name}.#{action_name.to_s}",
        {
          resource_name: human_name || resource_human_name,
          downcased_resource_name: human_name ? human_name.downcase : 
            resource_human_name.downcase,
          collection_name: collection_human_name,
          default: default_text
        })

      case action_name
      when :index
        link_to(text, collection_path)
      when :show
        link_to(text, resource_path(resource_instance || resource))
      when :new
        link_to(text, new_resource_path)
      when :edit
        link_to(text, edit_resource_path(resource_instance || resource), 
          class: collection_table_button_classes)
      when :delete
        link_to(text, resource_path(resource_instance || resource), 
          class: collection_table_button_classes,
          method: :delete, data: { 
            confirm: I18n.t('power_resource.confirmations.delete', 
                            default: 'Are you sure?') })
      end
    end
  end
end
