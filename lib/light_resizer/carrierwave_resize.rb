module LightResizer
  module CarrierWaveResize

    def resize_without_crop(width, height)
      resized_image_path(width, height, false)
    end

    alias_method :resize, :resize_without_crop

    def resize_with_crop(width, height)
      resized_image_path(width, height, true)
    end

    protected

    def resized_image_path(width, height, with_crop)
      File.join(File.dirname(url), 'light_resizer', with_crop ? 'crop' : '', "#{width}x#{height}", file.filename) if url
    end

  end
end
