module Queries
  class TagsQuery
    include Import[
      tag_repo: 'repositories.tags'
    ]

    def call
      tag_repo.all
    end
  end
end
