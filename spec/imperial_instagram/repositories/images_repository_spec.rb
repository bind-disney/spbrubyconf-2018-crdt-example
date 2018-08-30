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

  describe '#delete' do
    before { image_repository.create(image_entity) }

    it 'deletes a record from db' do
      image_repository.delete(image_uuid)

      expect(client.bucket_type('maps')
        .bucket('images')
        .exists?(image_uuid)).to be false
    end

    it 'deletes record uuid form images list' do
      image_repository.delete(image_uuid)

      list = Riak::Crdt::Set.new(image_bucket, 'images', 'sets')
      expect(list.members.to_a).not_to include(image_uuid)
    end
  end

  describe '#all' do
    let!(:expectation) { [image_repository.create(image_entity)] }

    it 'returns array with created image records' do
      expect(image_repository.all.count).to eq 1
      expect(image_repository.all).to all(be_a_kind_of(Riak::Crdt::Map))
    end
  end

  describe '#find_by_uuid' do
    let!(:expectation) { image_repository.create(image_entity) }

    it 'returns Image record by its uuid' do
      expect(image_repository.find_by_uuid(image_uuid)).to eq(expectation)
    end
  end
end
