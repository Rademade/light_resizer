require 'spec_helper'

describe LightResizer::Middleware::Resizer do

  let(:resizer) { described_class.new }
  let(:image_path) { File.join(ROOT, 'fixtures', 'avatar.png') }
  let(:resize_image_path) { File.join(ROOT, 'fixtures', 'resize', image_name) }

  context 'resize' do

    after do
      File.delete( resize_image_path )
    end

    context 'without crop' do
      let(:image_name) { '50x50_avatar.png' }

      it 'should create resized image file' do
        resizer.resize('50x50', image_path, resize_image_path, false)
        expect(File.exist?(resize_image_path)).to eq(true)
      end
    end

    context 'with crop' do
      let(:image_name) { '50x50_crop_avatar.png' }
      
      it 'should create resized image file' do
        resizer.resize('50x50', image_path, resize_image_path, true)
        expect(File.exist?(resize_image_path)).to eq(true)
      end
    end

  end

end