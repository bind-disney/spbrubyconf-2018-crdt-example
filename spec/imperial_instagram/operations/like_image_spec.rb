RSpec.describe Operations::LikeImage do
  include_context 'shared image'

  after do
    client.bucket_type('maps').bucket(image_bucket.name).delete(image_uuid)
  end

  describe '@call' do

    it 'creates Comment and assigns it to Image' do
      operation = Operations::LikeImage.new
      operation.call(image_uuid: image_uuid)

      image = image_repository.find_by_uuid(image_uuid)
      expect(image.counters['likes'].value).to eq 1
    end
  end
end
