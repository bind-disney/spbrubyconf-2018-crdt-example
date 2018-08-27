module Web::Controllers::Tags
  class Index
    include Web::Action

    def call(params)
      data = TagRepository.new.all

      self.body = data.to_json
    end
  end
end
