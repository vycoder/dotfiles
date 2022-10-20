return function(hl)
  -- use helper function to get highlight group properties
  hl.blank_bg = astronvim.get_hlgroup("Folded").fg
  hl.file_info_bg = astronvim.get_hlgroup("Visual").bg
  hl.nav_icon_bg = astronvim.get_hlgroup("String").fg
  hl.folder_icon_bg = astronvim.get_hlgroup("Error").fg
  return hl
end
