# encoding: utf-8
module LightResizer
  class Middleware
    class Path

      attr_reader :request_path

      def request_path=(path)
        @request_path = path
        @segments = nil
      end

      # {Bool} returns true if request path begins with 'image'
      def image_path?
        segments[1].start_with?('resize_image')
      end


      # {Bool} returns true if image should be croped on resize
      def crop_path?
        segments[1].end_with?('crop')
      end

      # {String} last part of request – relative path
      def image_path
        '/' + segments[3..-1].join('/')
      end

      # {Array} returns required dimensions of image. Like a 200x200
      def dimensions
        #todo validate params!
        segments[2]
      end

      # {String} returns prefix of resized image name
      # image.png => 200x200_crop_image.png
      def prefix
        crop_prefix = crop_path? ? '_crop' : ''

        dimensions + crop_prefix
      end

      def segments
        @segments ||= request_path.split('/')
      end

    end
  end
end