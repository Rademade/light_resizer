module LightResizer
  class Middleware
    def initialize(app, root, folder='public')
      @app_root      = root
      @public_folder = folder
      @app           = app
    end

    def call(env)
      @path = nil
      @splited_path = nil
      @env = env
      handle

      status, headers, response = @app.call(@env)

      [status, headers, response]
    end

    private

    # Handle request.
    # resizes images and
    # modificates env
    def handle
      if is_image_path?
        resize! unless image_exist

        modify_path!
      end
    end

    # creates new resized verion of requested image
    def resize!
      image = MiniMagick::Image.open(original_path)
      image.combine_options do |c|
        c.resize dimensions+'^'
        c.unsharp '0x1'
        c.add_command('extent', dimensions)
        c.gravity 'center'
      end
      image.write resized_image_filepath
    end

    # {Bool} returns true if image exist
    def image_exist
      File.exist?(resized_image_filepath)
    end

    # Modifies path to resized image
    def modify_path!
      @env['PATH_INFO'] = resized_image_path
    end

    # {String} returns site path to resized image
    # /image/200x200/.../image.png => /.../200x200_image.png
    def resized_image_path
      dir      = File.dirname(File.join(splited_path[3..-1]))
      filename = File.basename(File.join(splited_path[3..-1]))

      dir = '/' if dir == '.'
      filename = dimensions + '_' + filename

      File.join(dir, filename)
    end

    # {String} returns full path to resized image
    # /image/200x200/.../image.png => {APP_ROOT}/{@public_folder}/.../200x200_image.png
    def resized_image_filepath
      File.join(@app_root, @public_folder, resized_image_path)
    end

    # {String} returns full path of image that will be resized
    def original_path
      File.join(@app_root, @public_folder, splited_path[3..-1])
    end

    # {String} requested path
    def path
      @path ||= @env['PATH_INFO']
    end

    # {Bool} returns true if request path begins with 'image'
    def is_image_path?
      splited_path[1] == 'image'
    end

    # {Array} returns required dimensions of image
    # '/image/200x200/...'' => '200x200'
    def dimensions
      splited_path[2]
    end

    def splited_path
      @splited_path ||= path.split('/')
    end
  end
end