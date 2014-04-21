module LightResizer
  module CarrierWaveResize
    def resize(width, height)
      start = "/resize_image/#{width}x#{height}"
      File.join(start, url)
    end

    def resize_crop(width, height)
      start = "/resize_image_crop/#{width}x#{height}"
      File.join(start, url)
    end
  end
end