require_relative '../sample/settings'

@servers = {}

def node; NODE end

def method_missing(m, *args)
  return super unless STEPS.include? m.to_s
  @servers[@current] << {
    type: m.to_s,
    name: args[0]
  }
end

SERVERS.each do |k, v|
  @current = k
  @servers[@current] = []
  require_relative v
end

@servers.each do |name, server|
  p "Server #{name}"
  server.each do |step|
    p "#{step[:type]} #{step[:name]}"
  end
end

