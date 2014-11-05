module LightResizer
  module CarrierWaveResize

    def resize_without_crop(width, height)
      filename_prefix = "#{width}x#{height}_"
      resized_image_path(filename_prefix, 'png')
    end

    alias_method :resize, :resize_without_crop

    def resize_with_crop(width, height)
      filename_prefix = "#{width}x#{height}_crop_"
      resized_image_path(filename_prefix)
    end

    def crop(image_path, x, y, width, height)
      image = ::Magick::Image.read(image_path).first
      image.crop!(x.to_i, y.to_i, width.to_i, height.to_i)
      image.write("#{Rails.root}/tmp/cache/#{x}_#{y}_#{width}_#{height}_#{/([^\/]*)$/.match(image_path)[1]}")
      File.open(image.filename)
    end

    private

    def resized_image_path(prefix, extension = 'png')
      if url
        filename = File.basename(url, '.*')
        new_filename = "#{prefix}#{filename}.#{extension}"
        File.join(File.dirname(url), 'light_resize', new_filename)
      end
    end

  end
end