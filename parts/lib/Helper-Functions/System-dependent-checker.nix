{
  function =
    {
      hostname,
      username,
      concatenation_type,
      portable_content,
      laptop_content,
      desktop_content,
      backup_content,
    }:
    let
      extra_content =
        if username == "insomniac" && hostname == "laptop" then
          laptop_content
        else if username == "insomniac" && hostname == "desktop" then
          desktop_content
        else
          backup_content;
    in
    if concatenation_type == "list" then
      portable_content ++ extra_content
    else if concatenation_type == "attribute" then
      portable_content // extra_content
    else
      portable_content;
}
