module Web::Representers
  class CommentsRepresenter < Representable::Decorator
    include Representable::JSON::Collection

    items do
      property :key, as: :uuid
      property :author, exec_context: :decorator
      property :text, exec_context: :decorator

      def author
        represented.registers[:author]
      end

      def text
        represented.registers[:text]
      end
    end
  end
end
