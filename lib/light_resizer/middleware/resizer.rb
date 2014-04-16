# encoding: utf-8
module LightResizer
  class Middleware
    class Resizer

      def resize(dimensions, original_path, resize_path)
        check_resized_dir resize_path
        store_image dimensions, original_path, resize_path
      end

      private
      def check_resized_dir(resize_path)
        dir_name = File.dirname resize_path
        Dir.mkdir dir_name unless Dir.exist? dir_name
        #todo permissions?
      end

      def store_image(dimensions, original_path, resize_path)
        image = MiniMagick::Image.open original_path
        image.combine_options do |c|
          c.resize dimensions+'^'
          c.unsharp '0x1'
          c.add_command 'extent', dimensions
          c.gravity 'center'
        end
        image.write resize_path
      end

    end
  end
end