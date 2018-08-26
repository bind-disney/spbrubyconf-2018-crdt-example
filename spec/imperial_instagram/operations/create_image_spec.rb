RSpec.describe Operations::CreateImage do
  include_context 'shared image'

  before do
    allow_any_instance_of(Image).to receive(:uuid).and_return(image_uuid)
  end

  after do
    client.bucket_type('maps').bucket(image_bucket.name).delete(image_uuid)
  end

  describe '@call' do
    let(:image) { Riak::Crdt::Map.new(image_bucket, image_uuid) } 

    it 'creates Comment and assigns it to Image' do
      operation = Operations::CreateImage.new
      operation.call(image_params: image_params)

      expect(image_repository.find_by_uuid(image_uuid)).to be_a_kind_of Riak::Crdt::Map
    end
  end
end
