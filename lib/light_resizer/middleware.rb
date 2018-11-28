# encoding: utf-8
module LightResizer
  class Middleware

    def initialize(app, root)
      @app = app
      @public_path = app.try(:public_path) || "#{root}/public"
    end

    def call(env)
      Rails.logger.debug "Inside middleware call"
      resize_options = env['PATH_INFO'].match resize_url_regex
      Rails.logger.debug "resize_options: #{resize_options}"
      unless resize_options.nil?
        Rails.logger.debug "Inside middleware if"
        resizer = LightResizer::Resizer.new(@public_path, resize_options)
        resizer.process
      end
      @app.call(env)
    end

    protected

    def resize_url_regex
      /^(?<path>(?<directory>\/.+?)\/light_resizer\/(?<crop>crop\/)?(?<width>\d+)x(?<height>\d+)\/(?<image>.+?))(?<ext>\.\w+)$/
    end

  end
end
