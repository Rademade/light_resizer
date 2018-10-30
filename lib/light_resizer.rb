require 'light_resizer/version'
require 'light_resizer/resizer'
require 'light_resizer/compressor'
require 'light_resizer/dimension_not_found'
require 'light_resizer/middleware'
require 'light_resizer/carrierwave_resize'
require 'rmagick'
require 'configurations'

module LightResizer

  include Configurations

  configurable Array, :allowed_dimensions
  configurable Integer, :jpeg_quality
  configurable Integer, :png_compression

  configuration_defaults do |default_config|
    default_config.allowed_dimensions = []
    default_config.jpeg_quality = 100
    default_config.png_compression = 0
  end

end
