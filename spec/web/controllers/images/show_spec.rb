RSpec.describe Web::Controllers::Images::Show, type: :action do
  include_context 'shared image'
  
  let(:action) { described_class.new }
  let(:params) { Hash[] }

  before do
    allow_any_instance_of(Image).to receive(:uuid).and_return(uuid)
    repository.save(image_entity)
  end

  after do
    client.bucket_type('maps').bucket('images').delete(uuid)
  end

  it 'is successful' do
    response = action.call(params)
    expect(response[0]).to eq 200
  end
end
