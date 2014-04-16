require 'spec_helper'

describe LightResizer::Middleware::Path do

  let(:path) { described_class.new }

  context 'valid path methods' do

    before(:each) do
      path.request_path = '/resize_image/150x150/some_dir/image.png'
    end

    it { expect(path.send(:image_path?)).to eq(true) }

    it { expect(path.send(:image_path)).to eq('/some_dir/image.png') }

    it { expect(path.send(:dimensions)).to eq('150x150') }

  end

  context 'wrong path methods' do

    before(:each) do
      path.request_path = '/asdada/123acad/some_dir/imdage.png'
    end

    it { expect(path.send(:image_path?)).to eq(false) }

  end

end