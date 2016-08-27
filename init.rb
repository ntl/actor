dep_lib_dir = File.expand_path 'installed-packages/lib'
$LOAD_PATH.unshift dep_lib_dir unless $LOAD_PATH.include? dep_lib_dir

lib_dir = File.expand_path 'lib'
$LOAD_PATH.unshift lib_dir unless $LOAD_PATH.include? lib_dir

require 'actor'
