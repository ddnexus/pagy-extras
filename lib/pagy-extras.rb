# See the Pagy Extras documentation: https://ddnexus.github.io/pagy/pagy-extras

require 'pagy'

module Pagy
  def self.extras_root; Pathname.new(__FILE__).dirname end
end

require 'pagy-extras/bootstrap'
require 'pagy-extras/compact'
require 'pagy-extras/responsive'

