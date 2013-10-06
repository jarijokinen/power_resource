class CategoriesController < PowerResource::BaseController
  def permit_attributes
    %w(name)
  end
end
