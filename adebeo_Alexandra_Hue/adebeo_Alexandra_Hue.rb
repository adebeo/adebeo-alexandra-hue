require "adebeo_Alexandra_Hue"+"/adebeo-Option.rb"
require "adebeo_Alexandra_Hue"+"/adebeo-hue-core.rb"
require "adebeo_Alexandra_Hue"+"/adebeo-Toolbar.rb"

module Adebeohue
  extend AdebeoHueCore
  extend AdebeoHueToolbar
  extend AdebeoHueOption
end

if not file_loaded?("adebeo_Alexandra_Hue"+".rb")
 Adebeohue.adebeohueTooleBar()
end

file_loaded("adebeo_Alexandra_Hue"+".rb")