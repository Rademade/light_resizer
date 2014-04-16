require 'spec_helper'

describe LightResizer::ImageLoader::ResizeImage do

  let(:root_dir) { File.join(ROOT, 'fixtures') }
  let(:store_dir) { '/some/dir' }
  let(:original_filename) { 'image.png' }
  let(:resized_prefix) { '20x20' }
  let(:resized_image) { described_class.new root_dir }

  before(:each) do
    resized_image.original_filename = original_filename
    resized_image.original_relative_dir = store_dir
    resized_image.resize_prefix = resized_prefix
  end

  context 'path methods' do

    it {
      expected_filename = [resized_prefix, '_', original_filename].join('')
      expect(resized_image.send(:filename)).to eq( expected_filename )
    }

    it {
      expected_path = File.join(store_dir, resized_image.resize_prefix_dir, resized_image.filename)
      expect(resized_image.send(:relative_path)).to eq( expected_path )
    }

    it {
      expected_path = File.join(root_dir, resized_image.relative_path )
      expect(resized_image.send(:full_path)).to eq( expected_path )
    }

    it {
      expected_path = File.join(root_dir, store_dir, resized_image.resize_prefix_dir )
      expect(resized_image.send(:dir_path)).to eq( expected_path )
    }

    it { expect(resized_image.send(:dir_exist?)).to eq(false) }

    it { expect(resized_image.send(:image_exist?)).to eq(false) }

  end

end