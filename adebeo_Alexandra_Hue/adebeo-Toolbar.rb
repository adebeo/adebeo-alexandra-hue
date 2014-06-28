module AdebeoHueToolbar
  def adebeohueTooleBar

    adebeoToolbarName = "adebeo Philips Hue"
    toolbar = UI::Toolbar.new adebeoToolbarName      
    plugins_menu = UI.menu("Plugins")
    submenu = plugins_menu.add_submenu(adebeoToolbarName)
  
    cmdAdebeohue2 = UI::Command.new("Option hue"){Adebeohue.hueOption(true)}
    cmdAdebeohue2.tooltip = "Option"
    cmdAdebeohue2.menu_text = "Option"
    adebeoIconPathSmall2 = "icon/"+"adebeohueOption"+"Small.png"
    adebeoIconPathlarge2 = "icon/"+"adebeohueOption"+"Large.png"    
    cmdAdebeohue2.small_icon = adebeoIconPathSmall2
    cmdAdebeohue2.large_icon = adebeoIconPathlarge2
    #toolbar = toolbar.add_item cmdAdebeohue2
    submenu.add_item(cmdAdebeohue2)
    
    cmdAdebeohue = UI::Command.new("Light observer on/off"){Adebeohue.ajoutObserveur}
    cmdAdebeohue.small_icon = "icon/faceCheckerpt.png"
    cmdAdebeohue.large_icon = "icon/faceCheckergd.png"
    $adebeoHuelightObserverStateConflitIsImpossibleCauseTheNameIsToLong = false
    cmdAdebeohue.set_validation_proc {
        if $adebeoHuelightObserverStateConflitIsImpossibleCauseTheNameIsToLong == true
            cmdAdebeohue.menu_text = cmdAdebeohue.tooltip = "Light observer on"
            MF_CHECKED
        else
            cmdAdebeohue.menu_text = cmdAdebeohue.tooltip = "Light observer off"
            MF_UNCHECKED
        end
    }
    toolbar = toolbar.add_item cmdAdebeohue
    submenu.add_item(cmdAdebeohue)
  end
end