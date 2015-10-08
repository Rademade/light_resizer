# encoding: utf-8
module LightResizer
  class Resizer

    def initialize(public_path)
      @public_path = public_path
    end

    def process(options)
      full_path = "#{@public_path}#{options}"
      return if File.exists? full_path
      read_image options
      resize_or_crop options
      create_directory File.dirname(full_path)
      save_image full_path
    end
    
    protected

    def read_image(options)
      original_path = "#{@public_path}#{options[:directory]}/#{options[:image]}"
      @image = ::Magick::Image.read(original_path).first
      @image.format = options[:extension]
    end

    def resize_or_crop(options)
      width = options[:width].to_i
      height = options[:height].to_i
      options[:crop].nil? ? resize(width, height) : crop(width, height)
    end

    def resize(width, height)
      @image.resize_to_fill!(width, height)
    end

    def crop(width, height)
      @image.resize_to_fit! width, height
      @image.background_color = 'Transparent'
      # does not work with simple gravity
      @image = @image.extent width, height, (@image.columns - width) / 2, (@image.rows - height) / 2
    end
    
    def create_directory(directory_name)
      FileUtils.mkpath(directory_name) unless Dir.exist? directory_name
    end
    
    def save_image(full_path)
      @image.write(full_path)
      ImageOptimizer.new(full_path, quiet: true).optimize
    end

  end
end