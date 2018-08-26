class TagsRepository
  BUCKET = 'tags'
  TYPE = Riak::Crdt::Set

  def initialize(client = Client)
    @client = client
    @bucket = @client.bucket(BUCKET)
  end

  def add(tag)
    all.add(tag)
  end

  def all
    TYPE.new(@bucket, BUCKET, 'sets')
  end

  def delete(tag)
    all.reload.remove(tag)
  end
end
