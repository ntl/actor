lib_dir = File.join(__dir__, 'lib')
$LOAD_PATH.unshift(lib_dir) unless $LOAD_PATH.include?(lib_dir)

gems_lib_dir = File.join(__dir__, 'gems', 'lib')
$LOAD_PATH.unshift(gems_lib_dir) unless $LOAD_PATH.include?(gems_lib_dir)

require 'actor'
