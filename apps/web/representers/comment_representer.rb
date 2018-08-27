module Web::Representers
  class CommentRepresenter < Representable::Decorator
    include Representable::JSON

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
