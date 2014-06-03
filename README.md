light-resizer
=============

[![Build Status](https://travis-ci.org/Rademade/light_resizer.svg?branch=master)](https://travis-ci.org/Rademade/light_resizer)

Rack middleware for image resizer. Can be integrated with CarrierWave.
Instalation
===========
Install gem:

    $ gem install light_resizer

And set it in config:
```ruby
config.middleware.insert_before(Rack::Sendfile, LightResizer::Middleware, Rails.root)
```


Usage
=====
For example we have image in public folder by next url:

>example.com/images/kitten.jpg

Url of resized image will be:

>example.com/images/**light_resize/100x150_kitten.jpg**

light_resizer will find */public/images/kitten.jpg* and create *light_resize* with resized to size of 100x150px image.

If you change extension of original image:

>example.com/images/light_resize/100x150_kitten.**png**

light_resize will convert image to a new extension.

Default resize doesn't crop image and fill new space with transparent background.

To crop image use '*crop*' in url:
>example.com/images/light_resize/100x150_crop_kitten.png




