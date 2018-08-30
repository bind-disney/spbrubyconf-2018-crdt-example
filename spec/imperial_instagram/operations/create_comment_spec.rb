RSpec.describe Operations::CreateComment do
  include_context 'shared image'
  include_context 'shared comment'

  subject(:call_operation) do
    described_class.new.call(image_uuid: test_image_uuid,
                             comment_params: comment_params)
  end

  let(:test_image_uuid) { image_uuid }

  before do
    allow_any_instance_of(Comment).to receive(:uuid).and_return(comment_uuid)
    allow_any_instance_of(Image).to receive(:uuid).and_return(image_uuid)
  end

  after do
    client.bucket_type('maps').bucket(comment_bucket.name).delete(comment_uuid)
    client.bucket_type('maps').bucket(image_bucket.name).delete(image_uuid)
  end

  describe '@call' do
    let(:expected_comment) { Riak::Crdt::Map.new(comment_bucket, comment_uuid) }
    let!(:image_for_comment) { ImagesRepository.new.create(Image.new(image_params)) } 

    context 'image exists' do
      it 'creates Comment and assigns it to Image' do
        call_operation

        image_for_comment.reload
        expect(image_for_comment.sets[:comments_uuids].members).to include(comment_uuid)
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
