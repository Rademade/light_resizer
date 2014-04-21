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

      env['PATH_INFO'] = resize_image_path if @path.image_path? and resize_request?

      @app.call( env )
    end

    def resize_request?
        @image_loader.original_image_path = @path.image_path
        @image_loader.resize_prefix = @path.prefix

        @image_loader.original_image_exist?
    end

    private

    def resize_image_path
      unless @image_loader.resized_image_exist?
        @resizer.resize(@path.dimensions, @image_loader.original_path, @image_loader.resize_path, @path.crop_path?)
      end
      @image_loader.resized_image_relative_path
    end

  end
end