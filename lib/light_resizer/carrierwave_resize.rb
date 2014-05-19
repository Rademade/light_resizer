module LightResizer
  module CarrierWaveResize
    def resize_without_crop(width, height)
      filename_prefix = "#{width}x#{height}_"
      resized_image_path(filename_prefix)
    end

    alias :resize :resize_without_crop

    def resize_with_crop(width, height)
      filename_prefix = "#{width}x#{height}_crop_"
      resized_image_path(filename_prefix)
    end

    private
      def resized_image_path(prefix)
        if url
          path        = File.dirname(url)
          filename    = File.basename(url)
          new_filname = prefix + filename

          File.join(path, 'light_resize', new_filname)
        end
      end
  end
end