# encoding: utf-8
module LightResizer
  class Middleware
    class ImageLoader
      class ResizeImage

        STORE_RESIZE_DIR = 'resize' #todo move to const

        attr_accessor :resize_prefix

        def initialize(root_dir, original_image)
          @root_dir, @original_image = root_dir, original_image
        end

        # Resized file name '150x150_image.png'
        def filename
          resize_prefix + '_' + @original_image.filename
        end

        # Relative resize image path '/some_dir/resize/150x150_image.png'
        def relative_path
          File.join(@original_image.relative_dir, STORE_RESIZE_DIR, filename)
        end

        # Absolute image path
        def full_path
          File.join(@root_dir, relative_path)
        end

        # Absolute resize path {root}/some_dir/resize
        def dir_path
          File.dirname full_path
        end

        # {Bool} returns true if resize dir exist?
        def dir_exist?
          Dir.exist? dir_path
        end

        # {Bool} returns true if resize image exist?
        def image_exist?
          File.exist? full_path
        end

      end
    end
  end
end