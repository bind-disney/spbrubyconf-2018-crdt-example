class ImagesRepository
  BUCKET = 'images'
  TYPE = Riak::Crdt::Map

  def initialize(client)
    @client = client
    @bucket = @client.bucket(BUCKET)
  end

  def save(image)
    instance = TYPE.new(@bucket, image.uuid)

    instance.registers[:link] = image.link
    instance.registers[:author] = image.author
    image.tags.each do |tag|
      instance.sets[:tags].add(tag)
    end
    image.comments_uuids.each do |uuid|
      instance.sets[:comments_uuids].add(uuid)
    end

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
    TYPE.new(@bucket, uuid)
  end

  private

  def uuids_set
    bucket = @client.bucket(BUCKET + '_info_sets')

    Riak::Crdt::Set.new(bucket, BUCKET, 'sets')
  end
end
