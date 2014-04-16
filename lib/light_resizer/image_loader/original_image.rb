# encoding: utf-8
module LightResizer
  class Middleware
    class ImageLoader
      class OriginalImage

        attr_accessor :relative_path

        def initialize(root_dir)
          @root_dir = root_dir
        end

        # Full original image path /{root}/some_dir/image.png
        def full_path
          File.join(@root_dir, relative_path)
        end

        # Absolute store /{root}/some_dir
        def dir_path
          File.dirname( full_path ).to_s
        end

        # Requested filename /image.png
        def filename
          File.basename( full_path ).to_s
        end

        # Relative file store dir /some_dir/
        def relative_dir
          dir_path.gsub(@root_dir, '')
        end

        # {Bool} original image exist
        def image_exist?
          File.exist? full_path
        end

      end
    end
  end
end