require 'spec_helper'

describe LightResizer::ImageLoader::OriginalImage do

  let(:root_dir) { File.join(ROOT, 'fixtures') }
  let(:store_dir) { '/some/dir' }
  let(:filename) { 'image.png' }
  let(:image_full_path) { File.join(root_dir, store_dir, filename) }
  let(:original_image) { described_class.new root_dir }

  before(:each) do
    original_image.relative_path = File.join(store_dir, filename)
  end

  context 'path methods' do

    it { expect(original_image.send(:full_path)).to eq(image_full_path) }

    it { expect(original_image.send(:dir_path)).to eq( File.join(root_dir, store_dir) ) }

    it { expect(original_image.send(:filename)).to eq( filename ) }

    it { expect(original_image.send(:relative_dir)).to eq(store_dir) }

    it { expect(original_image.send(:image_exist?)).to eq(false) }

  end

end