require_relative 'margot'

@margot = Margot.new

def node; @margot.node end

def self.method_missing(m, *args)
  super unless @margot.handle m, args
end

def margot(out, settings)
  @margot.run out, settings
end

require_relative '../sample/settings'
