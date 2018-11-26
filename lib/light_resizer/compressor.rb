# encoding: utf-8

require 'piet'

module LightResizer
  class Compressor

    def initialize(path_to_file)
      @path_to_file = path_to_file
    end

    def process
      options = { quality: LightResizer.configuration.jpeg_quality, level: LightResizer.configuration.png_compression, verbose: true }
      result = Piet.optimize(@path_to_file, options)
      Rails.logger.debug "Optimize passsed with result: #{result}"
    end

  end
end
