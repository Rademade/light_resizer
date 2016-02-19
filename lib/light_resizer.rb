require 'light_resizer/version'
require 'light_resizer/resizer'
require 'light_resizer/dimension_not_found'
require 'light_resizer/middleware'
require 'light_resizer/carrierwave_resize'
require 'rmagick'
require 'configurations'

module LightResizer

  include Configurations

  configurable Array, :allowed_dimensions

  configuration_defaults do |default_config|
    default_config.allowed_dimensions = []
  end

end