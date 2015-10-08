# -*- encoding : utf-8 -*-
require 'spec_helper'

describe 'CarrierWaveResize' do

  let(:uploader) do
    uploader = PhotoUploader.new
    uploader.retrieve_from_store!('test/dragon.jpg')
    uploader
  end
  
  it 'returns correct resized url' do
    expect(uploader.resize_without_crop(200, 200)).to eq '/uploads/test/light_resizer/200x200/dragon.jpg'
  end

  it 'returns correct resized url with crop' do
    expect(uploader.resize_with_crop(200, 200)).to eq '/uploads/test/light_resizer/crop/200x200/dragon.jpg'
  end

end