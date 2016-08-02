require "ostruct"
require "bigdecimal"
require "prawn"
require "prawn_shapes"
require "prawn/graph/version"
require "prawn/graph/calculations"

require "prawn/graph/chart_components"

require "prawn/graph/theme"
require "prawn/graph/series"

require "prawn/graph/extension"


Prawn::Document.extensions << Prawn::Graph::Extension