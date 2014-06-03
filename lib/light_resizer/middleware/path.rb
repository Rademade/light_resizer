# encoding: utf-8
module LightResizer
  class Middleware
    class Path

      PREFIX_REGEXP = /^[0-9]+x[0-9]+(_crop|_convert)*_/

      attr_reader :request_path

      def request_path=(path)
        @request_path = path
        @segments = nil
      end

      # {Bool} returns true if request path begins with 'image'
      def image_path?
        request_dir.end_with?('light_resize')
      end


      # {Bool} returns true if image should be croped on resize
      def crop_path?
        prefix =~ /crop/
      end

      # {Bool} returns true if image should be converted on resize
      def convert_path?
        prefix =~ /convert/
      end

      # {String} last part of request – relative path
      def image_path
        dir = File.expand_path('..', request_dir)
        File.join(dir, original_filename)
      end

      def image_extension
        File.extname(request_path)
      end


      # {String} returns prefix of resized image name
      # 200x200_crop_image.png => 200x200_crop
      def prefix
        filename[PREFIX_REGEXP].chop if image_path?
      end

      def dimensions
        prefix.split('_').first
      end

      private

      def request_dir
        File.dirname(request_path)
      end

      def original_filename
        filename.gsub(PREFIX_REGEXP, '')
      end

      def filename
        File.basename(request_path, '.*')
      end

      def name_segments
        @segments ||= request_path.split('/')
      end
    end
  end
end