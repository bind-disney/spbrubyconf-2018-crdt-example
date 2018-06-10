class CommentsRepository
  BUCKET = 'comments'
  TYPE = Riak::Crdt::Map

  def initialize(client)
    @client = client
    @bucket = @client.bucket(BUCKET)
  end

  def create(comment)
    instance = TYPE.new(@bucket, comment.uuid)

    instance.registers[:author] = comment.author
    instance.registers[:text] = comment.text

    instance
  end

  def find_by_uuid(uuid)
    TYPE.new(@bucket, uuid)
  end

  def find_by_uuids(uuids)
    output_array = []

    uuids.each do |uuid|
      output_array << find_by_uuid(uuid)
    end

    output_array
  end
end
