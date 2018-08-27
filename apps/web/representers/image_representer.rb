module Web::Representers
  class ImageRepresenter < Representable::Decorator
    include Representable::JSON

		property :key, as: :uuid
		property :author, exec_context: :decorator
		property :link, exec_context: :decorator
		property :votes, exec_context: :decorator
		property :tags, exec_context: :decorator

		def author
			represented.registers[:author]
		end

		def link
			represented.registers[:link]
		end

		def votes
			represented.registers[:votes]
		end

		def tags
			represented.registers[:tags]
		end
  end
end
