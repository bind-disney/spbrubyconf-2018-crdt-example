require_relative './image_representer.rb'

module Web::Representers
  class ImageCommentsRepresenter < Representable::Decorator
    include Representable::JSON

    property :image, decorator: ImageRepresenter
    property :comments, decorator: CommentRepresenter.for_collection
  end
end
