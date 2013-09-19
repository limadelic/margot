require_relative '../sample/settings'

def method_missing(m, *args)
  return super unless NODES.include? m.to_s
  p "#{m} #{args[0]}"
end

require_relative '../sample/application'