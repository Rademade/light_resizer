require 'spec_helper'

describe LightResizer::ImageLoader do

  let(:root_dir) { File.join(ROOT, 'fixtures') }
  let(:image_loader) { described_class.new root_dir }

  before(:each) do
    image_loader.original_image_path = '/some/dir/image.png'
    image_loader.resize_prefix = '20x20'
  end

  context 'image loader methods' do

    it { expect(image_loader.send(:original_image_exist?)).to eq(false) }

    it { expect(image_loader.send(:resized_image_relative_path)).to eq('/some/dir/resize/20x20_image.png') }

    it { expect(image_loader.send(:resized_image_exist?)).to eq(false) }

  end

end