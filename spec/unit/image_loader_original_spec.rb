require 'spec_helper'

describe LightResizer::Middleware do
  let(:app) { AppEmulator.new }
  let(:resizer) { described_class.new(app, ROOT, 'fixtures') }
  let(:path) { File.join(ROOT, 'fixtures', '20x20_avatar.png') }

  before(:each) do
    resizer.call(env)
  end

  context 'path methods' do
    after do
      File.delete(path)
    end

    let(:env) { { 'PATH_INFO' => '/image/20x20/avatar.png' } }

    it { expect(resizer.send(:splited_path)).to eq(['', 'image', '20x20', 'avatar.png']) }

    it { expect(resizer.send(:dimensions)).to eq('20x20') }

    it { expect(resizer.send(:is_image_path?)).to eq(true) }

    it { expect(resizer.send(:path)).to eq('/image/20x20/avatar.png') }

    it { expect(resizer.send(:original_path)).to eq(File.join(ROOT, 'fixtures', 'avatar.png')) }

    it { expect(resizer.send(:resized_image_filepath)).to eq(path) }

    it { expect(resizer.send(:resized_image_path)).to eq('/20x20_avatar.png') }

    it { expect(resizer.send(:image_exist)).to eq(true) }
  end

  context 'with non image path' do

    let(:env) { { 'PATH_INFO' => '/lalala/20x20/avatar.png' } }

    it { expect(resizer.send(:is_image_path?)).to eq(false) }
  end
end