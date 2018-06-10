RSpec.shared_context "shared image", :shared_context => :metadata do
  let(:image_link) { 'https://i.imgur.com/YV2rXuG.jpg' }
  let(:image_author) { 'Bobba Fet' }
  let(:image_params) do
    {
      link: image_link,
      author: image_author,
      tags: [],
      comments_uuids: []
    }
  end
  let(:image_entity) { Image.new(image_params) }
  let(:client) { Riak::Client.new }
  let(:image_repository) { ImagesRepository.new(client) }
  let(:image_bucket) { client.bucket('images') }
  let(:image_uuid) { 'x' * 24 }
  let(:image) { image_repository.save(image_entity) }
end

RSpec.configure do |rspec|
  rspec.include_context "shared image", :include_shared => true
end
