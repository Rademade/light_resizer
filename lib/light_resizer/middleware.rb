# encoding: utf-8
require 'light_resizer/image_loader'
require 'light_resizer/middleware/path'
require 'light_resizer/middleware/resizer'

module LightResizer
  class Middleware

    def initialize(app, root, folder='public')
      @app           = app
      @image_loader  = LightResizer::ImageLoader.new File.join(root, folder)
      @path          = LightResizer::Middleware::Path.new
      @resizer       = LightResizer::Middleware::Resizer.new
    end

    def call(env)
      @path.request_path = env['PATH_INFO']

      if (@path.image_path? and resize_request?)
				resize
	      Rack::File.new(@image_loader.resized.root_dir).call(env) #todo check
      else
				@app.call(env)
      end

    end

    def resize_request?
        @image_loader.original_image_path = @path.image_path
        @image_loader.resize_prefix = @path.prefix

        @image_loader.original_image_exist?
    end

    private

    def resize
      unless @image_loader.resized_image_exist?
        @resizer.resize(@path.dimensions, @image_loader.original_path, @image_loader.resize_path, @path.crop_path?)
      end
    end

  end
end