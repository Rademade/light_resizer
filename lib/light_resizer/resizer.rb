# encoding: utf-8
module LightResizer
  class Resizer

    def initialize(public_path, options)
      @public_path = public_path
      @options = options
    end

    def process
      return if image_exists?
      resize_or_crop
      create_directory
      save_image
    end
    
    protected

    def image_exists?
      File.exists? full_path
    end

    def resize_or_crop
      check_allowed_dimension
      @options[:crop].nil? ? resize : crop
    end

    def check_allowed_dimension
      unless LightResizer.configuration.allowed_dimensions.empty? || LightResizer.configuration.allowed_dimensions.include?([width, height])
        raise DimensionNotFound, "Dimension #{width}x#{height} is not allowed"
      end
    end

    def crop
      image.resize_to_fill! width, height
    end

    def resize
      image.resize_to_fit! width, height
      image.background_color = 'Transparent'
      # does not work with simple gravity
      @image = image.extent width, height, (image.columns - width) / 2, (image.rows - height) / 2
    end
    
    def create_directory
      directory_name = File.dirname(full_path)
      FileUtils.mkpath(directory_name) unless Dir.exist? directory_name
    end
    
    def save_image
      image.write full_path
      ImageOptimizer.new(full_path, quiet: true).optimize
    end

    def image
      @image ||= ::Magick::Image.read("#{@public_path}#{@options[:directory]}/#{@options[:image]}").first
    end

    def full_path
      @full_path ||= "#{@public_path}#{@options}"
    end

    def width
      @width ||= @options[:width].to_i
    end

    def height
      @height ||= @options[:height].to_i
    end

  end
end