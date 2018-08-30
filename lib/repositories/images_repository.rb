class ImagesRepository
  BUCKET = 'images'
  BUCKET_TYPE = 'maps'
  ENTITY_TYPE = Riak::Crdt::Map

  def initialize(client = Client)
    @client = client
    @bucket = @client.bucket(BUCKET)
  end

  def create(image)
    instance = ENTITY_TYPE.new(@bucket, image.uuid)

    instance.registers[:link] = image.link
    instance.registers[:author] = image.author

    uuids_set.add(instance.key)

    instance
  end

  def all
    output_array = []

    uuids_set.members.each do |uuid|
      output_array << find_by_uuid(uuid)
    end

    output_array
  end

  def find_by_uuid(uuid)
    exists?(uuid) ? ENTITY_TYPE.new(@bucket, uuid) : nil
  end

  def delete(uuid)
    bucket_path.delete(uuid)
    uuids_set.reload.remove(uuid)
  end

  def delete_all
    all.select { |i| i != nil }.each do |image|
      delete(image.uuid)
    end

    uuids_set.members.each do |uuid|
      uuids_set.reload.remove(uuid)
    end

    true
  end

  private

  def uuids_set
    bucket = @client.bucket(BUCKET + '_info_sets')

    Riak::Crdt::Set.new(bucket, BUCKET, 'sets')
  end

  def exists?(uuid)
      bucket_path.exists?(uuid)
  end

  def bucket_path
    @client.bucket_type(BUCKET_TYPE)
      .bucket(BUCKET)
  end
end
