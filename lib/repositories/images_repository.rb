class ImagesRepository
  include Import[:db]

  BUCKET = 'images'
  BUCKET_TYPE = 'maps'
  ENTITY_TYPE = Riak::Crdt::Map

  def create(image)
    instance = ENTITY_TYPE.new(bucket, image.uuid)

    instance.registers[:link] = image.link
    instance.registers[:author] = image.author

    uuids_set.add(instance.key)

    instance
  end

  def all
    uuids_set.members.map { |uuid| find_by_uuid(uuid) }
  end

  def find_by_uuid(uuid)
    exists?(uuid) ? ENTITY_TYPE.new(bucket, uuid) : nil
  end

  def delete(uuid)
    bucket_path.delete(uuid)
    uuids_set.reload.remove(uuid)
  end

  def delete_all
    all.reject(&:nil?).each { |image| delete(image.uuid) }

    uuids_set.members.each do |uuid|
      uuids_set.reload.remove(uuid)
    end

    true
  end

  private

  def uuids_set
    bucket = db.bucket("#{BUCKET}_info_sets")

    Riak::Crdt::Set.new(bucket, BUCKET, 'sets')
  end

  def exists?(uuid)
    bucket_path.exists?(uuid)
  end

  def bucket_path
    db.bucket_type(BUCKET_TYPE).bucket(BUCKET)
  end

  def bucket
    @bucket ||= db.bucket(BUCKET)
  end
end
