module Web::Controllers::Images
  class Show
    include Web::Action

    def call(params)
      client = Riak::Client.new
      image = ImagesRepository.new(client).find_by_uuid(params[:id])
      comments = CommentsRepository.new(client).find_by_uuids(image.sets[:comments_uuids].members)

      image_representation = Web::Representers::ImageRepresenter.new(image)
      comments_representation = Web::Representers::CommentsRepresenter.new(comments)

      self.body = image_representation.to_hash.merge({ comments: comments_representation.to_hash }).to_json
    end
  end
end
