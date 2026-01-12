#!/usr/bin/env nu

glob ~/**/*.homemanagerbackup | each {rm $in};
def main [hostname?: string] {
  (nh os switch -H ($hostname | default (hostname)) .) 
}
