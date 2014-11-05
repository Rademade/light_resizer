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
        width, height = dimensions.split('x').map &:to_i

        @image = Magick::Image.read(Dir[original_path].first).first
        @image.format = extension[1..-1]

        # WARNING: DO NOT CHANGE COMMANDS ORDER FOR @IMAGE OBJECT
        # really, don't do this
        crop ? crop_image(width, height) : resize_image(width, height)

        @image.write(resize_path + extension)
      end
      
      def resize_image(width, height)
        @image.resize_to_fit!(width, height)
        @image.background_color = 'Transparent'
        @image = @image.extent(width, height, (@image.columns - width) / 2, (@image.rows - height) / 2) # does not work with simple gravity
      end
      
      def crop_image(width, height)
        @image.resize_to_fill!(width, height)
      end

    end
  end
end
