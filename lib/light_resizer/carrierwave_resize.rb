module LightResizer
  module CarrierWaveResize
    def resize(width, height)
      path = File.dirname(url)

      filename = File.basename(url)
      filename_prefix = "#{width}x#{height}_"
      new_filname = filename_prefix + filename
      
      File.join(path, 'light_resize', new_filname)
    end

    def resize_crop(width, height)
      path = File.dirname(url)

      filename = File.basename(url)
      filename_prefix = "#{width}x#{height}_crop_"
      new_filname = filename_prefix + filename
      
      File.join(path, 'light_resize', new_filname)
    end
  end
end