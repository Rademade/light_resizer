# encoding: utf-8
require 'light_resizer/image_loader/original_image'
require 'light_resizer/image_loader/resize_image'

module LightResizer
  class ImageLoader

    attr_reader :original, :resized

    def initialize(root_dir)
      @original = ImageLoader::OriginalImage.new(root_dir)
      @resized = ImageLoader::ResizeImage.new(root_dir)
    end

    def original_image_path=(path)
      #todo refresh @original image
      @original.relative_path = path
    end

    def resize_prefix=(prefix)
      #todo clear resize prefix
      @resized.original_filename = @original.filename
      @resized.original_relative_dir = @original.relative_dir
      @resized.resize_prefix = prefix
    end

    def original_path
      @original.full_path
    end

    def original_image_exist?
      @original.image_exist?
    end

    def resize_path
      @resized.full_path
    end

    def resized_image_relative_path
      @resized.relative_path
    end

    def resized_image_exist?
      @resized.image_exist?
    end

  end
end