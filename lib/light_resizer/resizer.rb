# encoding: utf-8
module LightResizer
  class Resizer

    def initialize(public_path, options)
      @public_path = public_path
      @options = options
    end

    def process
      full_path = "#{@public_path}#{@options}"
      return if File.exists? full_path
      read_image
      resize_or_crop
      create_directory File.dirname(full_path)
      save_image full_path
    end
    
    protected

    def read_image
      @image = ::Magick::Image.read("#{@public_path}#{@options[:directory]}/#{@options[:image]}").first
    end

    def resize_or_crop
      width = @options[:width].to_i
      height = @options[:height].to_i
      check_allowed_dimension width, height
      @options[:crop].nil? ? resize(width, height) : crop(width, height)
    end

    def check_allowed_dimension(width, height)
      unless LightResizer.configuration.allowed_dimensions.empty? || LightResizer.configuration.allowed_dimensions.include?([width, height])
        raise DimensionNotFound, "Dimension #{width}x#{height} is not allowed"
      end
    end

    def resize(width, height)
      @image.resize_to_fill! width, height
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
      @image.write full_path
      ImageOptimizer.new(full_path, quiet: true).optimize
    end

  end
end