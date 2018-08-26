RSpec.describe ImagesRepository do
  include_context 'shared image'

  before do
    allow_any_instance_of(Image).to receive(:uuid).and_return(image_uuid)
  end

  after do
    client.bucket_type('maps').bucket(image_bucket.name).delete(image_uuid)
  end

  describe '#create' do
    let(:expectation) { Riak::Crdt::Map.new(image_bucket, image_uuid) }

    it 'creates new Image record' do
      image_repository.create(image_entity)

      expect(expectation.registers[:link]).to eq image_link
      expect(expectation.registers[:author]).to eq image_author
    end
  end

  describe '#all' do
    let(:expectation) { [Riak::Crdt::Map.new(image_bucket, image_uuid)] }

    it 'returns array with created image record' do
      expect(image_repository.all).to eq(expectation)
    end
  end

  describe '#find_by_uuid' do
    let(:expectation) { Riak::Crdt::Map.new(image_bucket, image_uuid) }

    it 'returns Image record by its uuid' do
      expect(image_repository.find_by_uuid(image_uuid)).to eq(expectation)
    end
  end
end
