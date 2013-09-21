require 'json'
require_relative 'hash_spy'

class Margot

  attr_reader :node

  def initialize
    @node = HashSpy.new
    @servers = {}
  end

  def run(opts)
    @steps = opts[:steps]
    @cookbooks = opts[:cookbooks]
    @nodes = opts[:nodes]

    parse
    save
  end

  def handle(m, args)
    return unless @steps.include? m.to_s

    @servers[@current] << {
      step: m.to_s,
      cookbook: "#{args[0].to_s}".split('::').first,
      name: "#{args[0].to_s}".split('::').last
    }
  end

  def parse
    @nodes.each do |node|
      @current = node
      @servers[@current] = []
      require_relative "#{@cookbooks}/#{node}/recipes/default.rb"
    end
  end

  def save
    File.open('servers.jsonp', 'w') do |f|
      f.write "servers = #{@servers.to_json};"
    end
  end

end



