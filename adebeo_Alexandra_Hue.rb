#lamatrice-Entre-Prises.rb ex:lamatrice-Entre-Prises.rb
  require 'sketchup.rb'
  require 'extensions.rb'
  require "net/http"
  require "json"
    
  # Create the extension.
  ext = SketchupExtension.new 'adebeo Alexandra Hue','adebeo_Alexandra_Hue/adebeo_Alexandra_Hue.rb'

  # Attach some nice info.
  ext.creator     = 'adebeo, Inc.'
  ext.version     = '1.2'
  ext.copyright   = '2014, adebeo, Inc.'
  ext.description = 'Pilote Philipps Hue inside Sketchup'

  # Register and load the extension on startup.
  Sketchup.register_extension ext, true
  
