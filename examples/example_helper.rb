$LOAD_PATH.unshift(File.join(File.dirname(__FILE__),
                             %w[.. vendor prawn-core lib]))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require "rubygems"
require "prawn/core"
require "prawn/graph"
 
Prawn.debug = true
 
