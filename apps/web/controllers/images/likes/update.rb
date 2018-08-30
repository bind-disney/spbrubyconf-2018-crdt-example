module Web::Controllers::Likes
  class Update
    include Web::Action
    include Import[
      like_image: 'operations.like_image'
    ]

    def call(params)
      result = like_image.call(image_uuid: params[:image_id])

      if result.success?
        self.status = 200
        self.body = result.value!
      else
        self.status = 400
        self.body = result.failure
      end
    end
  end
end
