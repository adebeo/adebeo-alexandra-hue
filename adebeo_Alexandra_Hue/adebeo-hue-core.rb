module AdebeoHueCore
  def sendJSON(jsonson,lightid = "1")
  	http = Net::HTTP.new(@@options[:bridges][:defauls].to_s)
  	dev = @@options[:developer][:defauls].to_s+"adebeoHueSketchup"
  	request = Net::HTTP::Put.new("/api/#{dev}/lights/#{lightid}/state")
  	body = jsonson
  	body.to_json
  	request.body = body
  	response = http.request(request)
  end
  
  def convertRGB(mat)
  	col = mat.color
  	couleurs = [col.red,col.green,col.blue]
  	couleursh = []
  	couleurs.each {|couleur|couleursh << couleur/255.0}
  	cmax = couleursh.max.to_f
  	cmin = couleursh.min.to_f 
  	delta = cmax-cmin
  	h = s = l = (cmax + cmin) /2.0
  	if delta == 0.0
  		hsl = [0.0,0.0,l]
  	else
  		if l > 0.5
  			s = delta/(2-cmax-cmin)
  		else
  			s = delta/(cmax+cmin)
  		end
  		case cmax
  			when couleursh[0]
  				if couleursh[1]> couleursh[2]
  					secret = 6
  				else
  					secret = 0
  				end
  				h = (couleursh[1] - couleursh[2])/delta + secret
  			when couleursh[1]
  				h = (couleursh[2] - couleursh[0])/delta + 2
  			when couleursh[2]
  				h = (couleursh[0]-couleursh[1])/delta + 4	
  		end
  		h /= 6.0
  		hsl = [h,s,l]
  	end

  	if hsl[0] < 0
  		hsl[0] = 65535 + (hsl[0]*65535)
  	else
  		hsl[0] = hsl[0]*65535
  	end
  	hsl[1] = hsl[1]*255
  	hsl[2] = hsl[2]*255
  	return hsl
  end
  
  def ajoutObserveur
    if $adebeoHuelightObserverStateConflitIsImpossibleCauseTheNameIsToLong 
      #puts "remove obs"
      puts Sketchup.active_model.materials.remove_observer $adebeoHuelightObserver
      $adebeoHuelightObserverStateConflitIsImpossibleCauseTheNameIsToLong = false
    else
      @@options = Adebeohue.hueOption
      mats = Sketchup.active_model.materials
      $adebeoHuelightObserver = MatObserver.new
      $adebeoHuelightObserverStateConflitIsImpossibleCauseTheNameIsToLong = true
      #puts "add obs"
      puts mats.add_observer $adebeoHuelightObserver
    end
  end
  
end

class MatObserver < Sketchup::MaterialsObserver
	def onMaterialChange (mats,mat)
		lightName = mat.name
		if lightName[0,5].downcase == "light" 
		  lengthNqame = lightName.length
		  lightid = lightName[5..lengthNqame].to_i
  		jpetit = Adebeohue.convertRGB(mat)
			if jpetit[2].to_i < 50
				jsonson  = "{\"on\": false}"
			else
				jsonson = "{\"on\": true,\"hue\": #{jpetit[0].to_i},\"sat\": #{jpetit[1].to_i},\"bri\": #{jpetit[2].to_i}}"
			end
			Adebeohue.sendJSON(jsonson,lightid.to_s)
  	end
	end	
end
