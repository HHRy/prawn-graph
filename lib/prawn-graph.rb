require "prawn"
require "prawn/graph/version"
require "prawn/graph/calculations"

require "prawn/graph/theme"
require "prawn/graph/series"
require "prawn/graph/charts"

require "prawn/graph/extension"


Prawn::Document.extensions << Prawn::Graph::Extension