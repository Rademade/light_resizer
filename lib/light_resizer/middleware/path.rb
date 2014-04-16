# encoding: utf-8
module LightResizer
  class Middleware
    class Path

      attr_accessor :request_path

      def prepare_image_path(absolute_image_path)

      end


      # {Bool} returns true if request path begins with 'image'
      def image_path?
        splited_path[1] == 'resize_image'
      end

      # {Array} returns required dimensions of image
      # '/image/200x200/...'' => '200x200'
      #todo validate params!
      def dimensions
        splited_path[2]
      end

      def splited_path
        @splited_path ||= path.split('/')
      end

      def prepare_path(path)

      end

    end
  end
end