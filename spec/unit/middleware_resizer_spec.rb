require 'spec_helper'

describe LightResizer::Middleware::Resizer do

  let(:resizer) { described_class.new }
  let(:image_path) { File.join(ROOT, 'fixtures', 'sample') }
  let(:resize_image_path) { File.join(ROOT, 'fixtures', 'light_resize', image_name) }

  context 'resize' do

    after do
      File.delete( resize_image_path + '.png' )
    end

    context 'without crop' do
      let(:image_name) { '50x50_sample' }

      it 'should create resized image file' do
        resizer.resize('50x50', image_path, resize_image_path, false, '.png', true)
        expect(File.exist?(resize_image_path+'.png')).to eq(true)
      end
    end

    context 'with crop' do
      let(:image_name) { '50x50_crop_convert_sample' }

      it 'should create resized image file' do
        resizer.resize('50x50', image_path, resize_image_path, true, '.png', true)
        expect(File.exist?(resize_image_path+'.png')).to eq(true)
      end
    end

  end

end