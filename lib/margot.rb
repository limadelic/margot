require 'json'
require_relative 'hash_spy'

class Margot

  attr_reader :node

  def initialize
    @node = HashSpy.new
  end

  def run(steps, servers)
    @steps = steps
    @servers = servers
    parse
    save
  end

  def handle(m, args)
    return unless @steps.include? m.to_s

    @servers[@current] << {
      type: m.to_s,
      name: args[0].to_s
    }
  end

  def parse
    @servers.each do |name, role|
      @current = name
      @servers[@current] = []
      require_relative role
    end
  end

  def save
    File.open('status.json', 'w') {|f| f.write @servers.to_json }
  end

end



