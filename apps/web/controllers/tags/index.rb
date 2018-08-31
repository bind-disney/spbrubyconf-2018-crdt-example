module Web
  module Controllers
    module Tags
      class Index
        include Web::Action
        include Import[
          tag_repo: 'repositories.tags'
        ]

        def call(params)
          data = tag_repo.all

          respond_with(data)
        end
      end
    end
  end
end
