require 'spec_helper'

describe LightResizer::Middleware do
  let(:app) { AppEmulator.new }
  let(:resizer) { described_class.new(app, ROOT, 'fixtures') }
  let(:env) { { 'PATH_INFO' => '/image/20x20/avatar.png' } }
  let(:path) { File.join(ROOT, 'fixtures', '20x20_avatar.png') }

  after do
    File.delete(path)
  end

  it 'should create resized image' do
    resizer.call(env)

    expect(File.exist?(path)).to eq(true)
  end

  it 'should return right path' do
    resizer.call(env)

    expect(app.env['PATH_INFO']).to eq('/20x20_avatar.png')
  end
end