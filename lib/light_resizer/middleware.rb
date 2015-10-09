# encoding: utf-8
module LightResizer
  class Middleware

    def initialize(app, root)
      @app = app
      @public_path = app.try(:public_path) || "#{root}/public"
    end

    def call(env)
      resize_options = env['PATH_INFO'].match resize_url_regex
      LightResizer::Resizer.new(@public_path, resize_options).process unless resize_options.nil?
      @app.call(env)
    end

    protected

    def resize_url_regex
      /^(?<directory>\/.+?)\/light_resizer\/(?<crop>crop\/)?(?<width>\d+)x(?<height>\d+)\/(?<image>[^\/]+)$/
    end

  end
end