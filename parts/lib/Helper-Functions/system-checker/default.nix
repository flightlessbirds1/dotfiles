{
  system-checker = {
    hostname,
    username,
    concatenation_type,
    portable_content,
    unportable_content,
    backup_content,
  }:
    if username == "insomniac" && (hostname == "laptop" || hostname == "desktop")
    then
      if concatenation_type == "list"
      then portable_content ++ unportable_content
      else if concatenation_type == "attribute"
      then portable_content // unportable_content
      else portable_content
    else if concatenation_type == "list"
    then portable_content ++ backup_content
    else if concatenation_type == "attribute"
    then portable_content // backup_content
    else portable_content;
}
