class CommentsRepository
  include Import[:db]

  BUCKET = 'comments'
  TYPE = Riak::Crdt::Map

  def create(comment)
    instance = TYPE.new(bucket, comment.uuid)

    instance.registers[:author] = comment.author
    instance.registers[:text] = comment.text

    instance
  end

  def find_by_uuid(uuid)
    TYPE.new(bucket, uuid)
  end

  def find_by_uuids(uuids)
    uuids.map { |uuid| find_by_uuid(uuid) }
  end

  private

  def bucket
    @bucket ||= db.bucket(BUCKET)
  end
end
