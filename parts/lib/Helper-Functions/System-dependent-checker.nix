{
  function = {
    hostname,
    username,
    concatenation_type,
    portable_content,
    laptop_content,
    desktop_content,
    backup_content,
  }:
    if username == "insomniac" && hostname == "laptop"
    then
      if concatenation_type == "list"
      then portable_content ++ laptop_content
      else if concatenation_type == "attribute"
      then portable_content // laptop_content
      else portable_content
    else if username == "insomniac" && hostname == "desktop"
    then
      if concatenation_type == "list"
      then portable_content ++ desktop_content
      else if concatenation_type == "attribute"
      then portable_content // desktop_content
      else portable_content
    else if concatenation_type == "list"
    then portable_content ++ backup_content
    else if concatenation_type == "attribute"
    then portable_content // backup_content
    else portable_content;
}
