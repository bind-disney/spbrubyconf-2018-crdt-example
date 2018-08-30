RSpec.describe Operations::TagImage do
  include_context 'shared image'

  let(:tag) { 'Newtag' }
  let(:test_image_uuid) { image_uuid }
  let(:call_operation) { Operations::TagImage.new.call(image_uuid: test_image_uuid, tag: tag) }

  after do
    client.bucket_type('maps').bucket(image_bucket.name).delete(image_uuid)
    TagsRepository.new.delete(tag)
  end

  describe '@call' do
    let!(:image_for_tag) { ImagesRepository.new.create(Image.new(image_params)) } 

    context 'Image exists' do
      it 'creates tag and assigns it to Image' do
        call_operation

        image_for_tag.reload
        expect(image_for_tag.sets[:tags].members.to_a).to include(tag)
      end

      it 'adds tag to tags list' do
        call_operation

        expect(TagsRepository.new.all.members.to_a).to include(tag)
      end

      context 'tag wit multi words' do
        let(:tag) { 'Tag with spaces' }

        it 'converts tag to taggable format' do
          call_operation

          image_for_tag.reload
          expect(image_for_tag.sets[:tags].members.to_a).to include('TagWithSpaces')
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
end
