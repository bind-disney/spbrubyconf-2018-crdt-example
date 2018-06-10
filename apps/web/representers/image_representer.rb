module Web::Representers
  class ImageRepresenter < Representable::Decorator
    include Representable::JSON

    property :link, exec_context: :decorator
    property :author, exec_context: :decorator

    def link
      represented.registers[:link]
    end

    def author
      represented.registers[:author]
    end
  end
end
