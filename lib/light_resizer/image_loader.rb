# encoding: utf-8
require 'light_resizer/middleware/image_loader/original_image'
require 'light_resizer/middleware/image_loader/resize_image'

module LightResizer
  class Middleware
    class ImageLoader

      attr_reader :original, :resized

      def initialize(root_dir)
        @original = Middleware::ImageLoader::OriginalImage.new(root_dir)
        @resized = Middleware::ImageLoader::ResizeImage.new(root_dir, @original)
      end

      def original_image_path=(path)
        @original.relative_path = path
      end

      def resize_prefix=(prefix)
        @resized.resize_prefix = prefix
      end

      def resized_image_path
        @resized.relative_path
      end

      def original_image_exist?
        @original.image_exist?
      end

      def resized_image_exist?
        @resized.image_exist?
      end

    end
  end
end