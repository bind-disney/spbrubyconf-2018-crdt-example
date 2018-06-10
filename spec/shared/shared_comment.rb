RSpec.shared_context "shared comment", :shared_context => :metadata do
  let(:client) { Riak::Client.new }
  let(:comment_bucket) { client.bucket('comments') }
  let(:comment_text) { 'LOL' }
  let(:comment_author) { 'Darth Sidius' }
  let(:comment_params) do
    {
      author: comment_author,
      text: comment_text
    }
  end
  let(:comment_template) { Comment.new(comment_params) }
  let(:comment_repository) { CommentsRepository.new(client) }
  let(:comment_uuid) { 'x' * 24 }
end

RSpec.configure do |rspec|
  rspec.include_context "shared comment", :include_shared => true
end
