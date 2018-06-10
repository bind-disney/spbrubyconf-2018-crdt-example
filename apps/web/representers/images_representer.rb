module Web::Representers
  class ImagesRepresenter < Representable::Decorator
    include Representable::JSON::Collection

    items do
      property :key, as: :uuid
      property :author, exec_context: :decorator
      property :link, exec_context: :decorator

      def author
        represented.registers[:author]
      end

      def link
        represented.registers[:link]
      end
    end

  end
end
