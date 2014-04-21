require 'spec_helper'

describe LightResizer::Middleware::Path do

  let(:path) { described_class.new }

  context 'valid path methods' do

    before(:each) do
      path.request_path = '/some_dir/light_resize/150x150_image.png'
    end

    it { expect(path.image_path?).to be_true }

    it { expect(path.image_path).to eq('/some_dir/image.png') }

    it { expect(path.dimensions).to eq('150x150') }

    it { expect(path.prefix).to eq('150x150') }

  end

  context 'resize with crop' do
    before(:each) do
      path.request_path = '/some_dir/light_resize/150x150_crop_image.png'
    end

    it { expect(path.crop_path?).to be_true }

    it { expect(path.image_path).to eq('/some_dir/image.png') }

    it { expect(path.dimensions).to eq('150x150') }

    it { expect(path.prefix).to eq('150x150_crop') }
  end

  context 'wrong path methods' do

    before(:each) do
      path.request_path = '/asdada/123acad/some_dir/imdage.png'
    end

    it { expect(path.image_path?).to be_false }

  end

end