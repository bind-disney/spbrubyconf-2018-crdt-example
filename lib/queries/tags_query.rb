module Queries
  class TagsQuery
    def call
      TagsRepository.new.all
    end
  end
end
