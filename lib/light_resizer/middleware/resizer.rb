# encoding: utf-8
module LightResizer
  class Middleware
    class Resizer

      def resize(dimensions, original_path, resize_path, crop, extension, convert)
        check_resized_dir(resize_path)
        store_image(dimensions, original_path, resize_path, crop, extension)
      end

      private
      def check_resized_dir(resize_path)
        dir_name = File.dirname resize_path
        Dir.mkdir dir_name unless Dir.exist? dir_name
        #todo permissions?
      end

      def store_image(dimensions, original_path, resize_path, crop, extension)
        original_path += '.*'
        @image = MiniMagick::Image.open Dir[original_path].first

        @extension = extension[1..-1]

        # WARNING: DO NOT CHANGE COMMANDS ORDER FOR @IMAGE OBJECT
        # realy, don't do this
        @image.format(@extension)
        crop ? set_crop_options(dimensions) : set_options(dimensions)

        @image.write (resize_path + extension)
      end

      def set_options(dimensions)
        @image.combine_options do |c|
          c.adaptive_resize dimensions
          c.add_command 'quality', '90'
          c.add_command 'extent', dimensions
          c.gravity 'center'
          c.background 'transparent'
        end
      end

      def set_crop_options(dimensions)
        @image.combine_options do |c|
          c.adaptive_resize dimensions+'^'
          c.add_command 'quality', '90'
          c.add_command 'extent', dimensions
          c.gravity 'center'
        end
      end

    end
  end
end
