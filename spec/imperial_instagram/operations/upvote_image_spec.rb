RSpec.describe Operations::UpvoteImage do
  include_context 'shared image'

  after do
    client.bucket_type('maps').bucket(image_bucket.name).delete(image_uuid)
  end

  describe '@call' do

    it 'creates Comment and assigns it to Image' do
      operation = Operations::UpvoteImage.new
      operation.call(uuid: image_uuid)

      image = image_repository.find_by_uuid(image_uuid)
      expect(image.counters['votes'].value).to eq 1
    end
  end
end
