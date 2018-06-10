RSpec.describe Operations::CreateComment do
  include_context 'shared image'
  include_context 'shared comment'

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
    let(:image_for_comment) { Riak::Crdt::Map.new(image_bucket, image_uuid) } 

    it 'creates Comment and assigns it to Image' do
      operation = Operations::CreateComment.new(client)
      operation.call(image_uuid: image_uuid, comment_params: comment_params)

      expect(image_for_comment.sets[:comments_uuids].members).to include(comment_uuid)
    end
  end
end
