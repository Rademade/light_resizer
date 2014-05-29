# encoding: utf-8
module LightResizer
  class Middleware
    class Resizer

      def resize(dimensions, original_path, resize_path, crop)
        check_resized_dir(resize_path)
        store_image(dimensions, original_path, resize_path, crop)
      end

      private
      def check_resized_dir(resize_path)
        dir_name = File.dirname resize_path
        Dir.mkdir dir_name unless Dir.exist? dir_name
        #todo permissions?
      end

      def store_image(dimensions, original_path, resize_path, crop)
        @image = MiniMagick::Image.open original_path

        crop ? set_crop_options(dimensions) : set_options(dimensions)

        @image.write resize_path
      end

      def set_options(dimensions)
        @image.combine_options do |c|
          c.adaptive_resize dimensions
          c.add_command 'quality', '0'
          c.add_command 'extent', dimensions
          c.gravity 'center'
        end
      end

      def set_crop_options(dimensions)
        @image.combine_options do |c|
          c.adaptive_resize dimensions+'^'
          c.add_command 'quality', '0'
          c.add_command 'extent', dimensions
          c.gravity 'center'
        end
      end

    end
  end
end