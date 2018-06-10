RSpec.describe CommentsRepository do
  include_context 'shared comment'

  before do
    allow_any_instance_of(Comment).to receive(:uuid).and_return(comment_uuid)
  end

  after do
    client.bucket_type('maps').bucket(comment_bucket.name).delete(comment_uuid)
  end

  describe '#save' do
    let(:expectation) { Riak::Crdt::Map.new(comment_bucket, comment_uuid) }

    it 'creates new Comment record' do
      comment_repository.create(comment_template)

      expect(expectation.registers[:text]).to eq comment_text
    end
  end

  describe '#find_by_uuid' do
    let(:expectation) { Riak::Crdt::Map.new(comment_bucket, comment_uuid) }

    it 'returns Comment record' do
      expect(comment_repository.find_by_uuid(comment_uuid)).to eq(expectation)
    end
  end

  describe '#find_by_uuids' do
    let(:expectation) { [Riak::Crdt::Map.new(comment_bucket, comment_uuid)] }

    it 'returns array of Comment records' do
      expect(comment_repository.find_by_uuids([comment_uuid])).to eq expectation
    end
  end
end
