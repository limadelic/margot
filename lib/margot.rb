require 'json'
require_relative 'hash_spy'

class Margot

  attr_reader :node

  def initialize
    @node = HashSpy.new
    @servers = {}
  end

  def set_up env, opts
    @env = env
    @steps = opts[:steps]
    @cookbooks = opts[:cookbooks]
    @logs = opts[:logs]
    @nodes = opts[:nodes]
  end

  def run env, opts
    set_up env, opts
    parse
    set_status
    save
  end

  def handle(m, args)
    return unless @steps.include? m.to_s
    @servers[@current] << parse_step(m.to_s, args[0].to_s)
  end

  def parse_step(type, full_name)
    name_tokens = "#{full_name}".split '::'

    {
      step: type,
      cookbook: name_tokens.first,
      name: name_tokens.last,
      full_name: name_tokens.length == 1 ?
        "#{full_name}::default" : full_name
    }
  end

  def parse
    @nodes.each_key do |node|
      @current = node
      @servers[@current] = []
      require_relative "#{@cookbooks}/#{node}/recipes/default.rb"
    end
  end

  def set_status
    @nodes.each do |name, suffix|
      log = File.read "#{@logs}/#{@env}#{suffix}/chef_deploy.log"
      @servers[name].each do |step|
        step[:done] = log.include? step[:full_name]
      end
    end
  end

  def save
    File.open('servers.jsonp', 'w') do |f|
      f.write "servers = #{@servers.to_json};"
    end
  end

end



