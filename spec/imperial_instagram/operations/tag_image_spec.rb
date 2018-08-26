RSpec.describe Operations::TagImage do
  include_context 'shared image'
  let(:tag) { 'NewTag' }
  let(:operation) { Operations::TagImage.new }

  after do
    client.bucket_type('maps').bucket(image_bucket.name).delete(image_uuid)
    TagsRepository.new.delete(tag)
  end

  describe '@call' do
    it 'creates tag and assigns it to Image' do
      operation.call(image_uuid: image_uuid, tag: tag)

      image = image_repository.find_by_uuid(image_uuid)
      expect(image.sets[:tags].members).to include(tag)
    end

    it 'adds tag to tags list' do
      operation.call(image_uuid: image_uuid, tag: tag)

      expect(TagsRepository.new.all.members).to include(tag)
    end
  end
end
