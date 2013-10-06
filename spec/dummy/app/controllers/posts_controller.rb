class PostsController < PowerResource::BaseController
  def permit_attributes
    %w(category_id title content)
  end
end
