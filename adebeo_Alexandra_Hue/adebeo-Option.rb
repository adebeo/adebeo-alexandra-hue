module AdebeoHueOption
  def hueOption(force = false)
        adebeohueFichierOption = "hueOption.txt"
        @@options = 
        {
          :bridges =>
                  { :promt => "bridge ip address :",
                    :list => "",
                    :defauls => ""
                  },
          :developer =>
                  { :promt => "Developer :",
                    :list => "",
                    :defauls => "newdeveloper"
                  }
        }

        mpath=File.dirname(File.expand_path(Sketchup.find_support_file "adebeo_Alexandra_Hue.rb", "Plugins/"))+"/adebeo_Alexandra_Hue"+"/#{adebeohueFichierOption}"
      
        doit = true
        if File.exist?(mpath) 
     			monfichier=File.open(mpath)
    			lesLignesQuiSontlueS = monfichier.readlines
    			monfichier.close
  			
    			lesLignesQuiSontlueS.each {|lignelue|
    			  valeurLuelues = lignelue.to_s().strip.split("=")
    			  @@options[valeurLuelues[0].to_sym][:defauls] = valeurLuelues[1]
    			}

    			doit =false     
        end
      
  			if doit || force
  			  prompts = []
  				@@options.each{|key,option| prompts << option[:promt]}
				
  				defauls = []
  				@@options.each{|key,option| 
  				  if option[:list] != ""
    				  indexValeurPardefaut = option[:defauls].to_i
    				  listDeValeur = option[:list].split("|")
    				  defauls << listDeValeur[indexValeurPardefaut]
    				else
    				  defauls << option[:defauls].to_s
    				end
  				} 
				
  				list = []
  			  @@options.each{|key,option| list << option[:list]}    
  			  boiteDoption = UI.inputbox prompts, defauls, list, "Options..." 
          n = 0
  				pageoption =""
  				@@options.each{|key,value|
  				  pageoption+= key.to_s 
  				  pageoption+= "="
  				  option = @@options[key]
  				  if option[:list] != ""
  				    listDeValeur = option[:list].split("|")
  				    indexValeurPardefaut = listDeValeur.index(boiteDoption[n].to_s).to_i
  				  else
  				    indexValeurPardefaut = boiteDoption[n].to_s
  				  end
  				  pageoption+= indexValeurPardefaut.to_s
  				  pageoption+= "
  "
  				  n+=1
  				}
  				pageoptionfile=File.new(mpath,"w")
  				pageoptionfile.puts(pageoption)
  				pageoptionfile.close
  			  Adebeohue.createNewDeveloper(@@options)
        else
    	  end
        return @@options
  end
  
  def createNewDeveloper(options)
    @@options = options
    newdeveloper = @@options[:developer][:defauls]+"adebeoHueSketchup"
    UI.messagebox("Go and press the button on the bridge. After click Ok")
    http = Net::HTTP.new(@@options[:bridges][:defauls].to_s)
  	request = Net::HTTP::Post.new("/api")
  	body = "{\"devicetype\":\"test user\",\"username\":\"#{newdeveloper}\"}"
  	body.to_json
  	request.body = body
  	response = http.request(request)
  end
end