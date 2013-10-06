module Backend
  class CommentsController < PowerResource::BaseController
    belongs_to :post

    def permit_attributes
      %w(content author)
    end
  end
end
