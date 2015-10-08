# encoding: utf-8
class PhotoUploader < CarrierWave::Uploader::Base
  include ::LightResizer::CarrierWaveResize

end