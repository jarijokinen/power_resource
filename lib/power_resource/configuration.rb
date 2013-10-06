module PowerResource
  module Configuration
    # Classes for collection tables
    #
    # Default values
    #
    # collection_table_classes = %w(table)
    mattr_accessor :collection_table_classes
    self.collection_table_classes = %w(table)
    
    # Classes for collection table buttons (edit, delete, etc.)
    #
    # Default values
    #
    # collection_table_button_classes = %w(btn btn-default btn-xs)
    mattr_accessor :collection_table_button_classes
    self.collection_table_button_classes = %w(btn btn-default btn-xs)
  end
end
