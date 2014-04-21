require 'spec_helper'

describe LightResizer::Middleware do
  let(:app) { AppEmulator.new }
  let(:resizer) { described_class.new(app, ROOT, 'fixtures') }
  let(:env) { { 'PATH_INFO' => '/resize_image/100x160/avatar.png' } }

  let(:resize_relative_path) { '/resize/100x160_avatar.png' } #todo depends for many constant
  let(:resize_full_path) { File.join(ROOT, 'fixtures', resize_relative_path) }

  after do
    File.delete resize_full_path
  end

  it 'should create resized image' do
    resizer.call(env)

    expect(resizer.resize_request?).to eq(true)
  end

  it 'should return right path' do
    resizer.call(env)

    expect(app.env['PATH_INFO']).to eq( resize_relative_path )
  end

end