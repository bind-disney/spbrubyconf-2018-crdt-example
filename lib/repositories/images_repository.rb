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

  private

  def uuids_set
    bucket = @client.bucket(BUCKET + '_info_sets')

    Riak::Crdt::Set.new(bucket, BUCKET, 'sets')
  end

  def exists?(uuid)
    @client.bucket_type(BUCKET_TYPE)
      .bucket(BUCKET)
      .exists?(uuid)
  end
end
