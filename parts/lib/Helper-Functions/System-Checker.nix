{
  function =
    {
      hostname,
      username,
      concatenation_type,
      portable_content,
      unportable_content,
      backup_content,
    }:
    let
      isTargetMachine = username == "insomniac" && (hostname == "laptop" || hostname == "desktop");
      extra_content = if isTargetMachine then unportable_content else backup_content;
    in
    if concatenation_type == "list" then
      portable_content ++ extra_content
    else if concatenation_type == "attribute" then
      portable_content // extra_content
    else
      portable_content;
}
