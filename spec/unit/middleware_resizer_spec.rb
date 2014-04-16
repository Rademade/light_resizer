require 'spec_helper'

describe LightResizer::Middleware::Resizer do

  let(:resizer) { described_class.new }
  let(:image_path) { File.join(ROOT, 'fixtures', 'avatar.png') }
  let(:resize_image_path) { File.join(ROOT, 'fixtures', 'resize', '50x50_avatar.png') }

  context 'resize' do

    after do
      File.delete( resize_image_path )
    end

    it {
      resizer.resize('50x50', image_path, resize_image_path)
      expect(File.exist?(resize_image_path)).to eq(true)
    }

  end

end