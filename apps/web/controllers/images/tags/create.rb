module Web::Controllers::Tags
  class Create
    include Web::Action

    def call(params)
      result = Operations::TagImage.new.call(image_uuid: params[:image_id],
                                             tag: params[:tag])
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
