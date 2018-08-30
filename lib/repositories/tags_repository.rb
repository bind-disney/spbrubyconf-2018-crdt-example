class TagsRepository
  include Import[:db]

  BUCKET = 'tags'
  TYPE = Riak::Crdt::Set

  def add(tag)
    all.add(tag)
  end

  def all
    TYPE.new(bucket, BUCKET, 'sets')
  end

  def delete(tag)
    all.reload.remove(tag)
  end

  private

  def bucket
    @bucket ||= db.bucket(BUCKET)
  end
end
