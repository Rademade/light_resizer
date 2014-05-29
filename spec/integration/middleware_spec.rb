require 'spec_helper'

describe LightResizer::Middleware do
  let(:app) { double("app") }
  let(:resizer) { described_class.new(app, ROOT, 'fixtures') }
  let(:env) { { 'PATH_INFO' =>  resize_relative_path} }

  let(:resize_full_path) { File.join(ROOT, 'fixtures', resize_relative_path) }

  context 'image path' do
    after(:each) do
      File.delete(resize_full_path)
    end
    let(:resize_relative_path) { '/light_resize/200x200_avatar.png' } #todo depends for many constant

    it 'should approve resize request' do
      resizer.call(env)

      expect(resizer.resize_request?).to be_true
    end

    it 'should create resized image' do
      expect(File.exist?(resize_full_path)).to be_false
      resizer.call(env)
      expect(File.exist?(resize_full_path)).to be_true
    end
  end

  context 'non image path' do
    let(:resize_relative_path) { 'some/other/path' }

    it 'should call app with right environment' do
      expect(app).to receive(:call).with(env)
      resizer.call(env)
    end
  end
end