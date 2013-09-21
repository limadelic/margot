require_relative 'margot'

@margot = Margot.new

def node; @margot.node end

def self.method_missing(m, *args)
  super unless @margot.handle m, args
end

def run(opts)
  @margot.run opts
end

require_relative '../sample/settings'
