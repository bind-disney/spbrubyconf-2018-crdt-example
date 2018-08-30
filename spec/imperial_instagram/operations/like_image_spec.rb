RSpec.describe Operations::LikeImage do
  include_context 'shared image'

  subject(:call_operation) do
    described_class.new.call(image_uuid: test_image_uuid)
  end

  let(:test_image_uuid) { image_uuid }

  before do
    allow_any_instance_of(Image).to receive(:uuid).and_return(image_uuid)
  end

  after do
    client.bucket_type('maps').bucket(image_bucket.name).delete(image_uuid)
  end

  describe '@call' do
    let!(:image_for_like) { ImagesRepository.new.create(Image.new(image_params)) } 

    context 'Image exists' do
      it 'Increases Image likes counter' do
        call_operation

        image_for_like.reload
        expect(image_for_like.counters['likes'].value).to eq 1
      end

      it 'returns Success' do
        expect(call_operation).to be_a_success
      end
    end

    context 'image not exists' do
      let(:test_image_uuid) { 'invaliduuid' }

      it 'returns Failure' do
        expect(call_operation).to be_a_failure
      end
    end
  end
end
