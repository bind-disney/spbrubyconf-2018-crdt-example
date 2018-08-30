module Web::Controllers::Tags
  class Create
    include Web::Action
    include Import[
      tag_image: 'operations.tag_image'
    ]

    params do
      required(:image_id).filled(:int?)
      required(:tag).filled(:str?)
    end

    def call(params)
      result = tag_image.call(image_uuid: params[:image_id], tag: params[:tag])

      respond_with(result, serializer)

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
