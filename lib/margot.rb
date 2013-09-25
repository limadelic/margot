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
      type: type,
      cookbook: name_tokens.first,
      name: name_tokens.last,
      status: 'pending',
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
      @log = File.read "#{@logs}/#{@env}#{suffix}/chef_deploy.log"
      @steps = @servers[name]
      set_status_from index_of_last_step_done + 1
    end
  end

  def set_status_from index
    set_done_steps index if index > 0
    set_current_step index if index < @steps.length - 1
  end

  def set_done_steps count
    @steps.take(count).each do |step|
      step[:status] = is_step_done?(step) ?
        'done' : 'skipped'
    end
  end

  def set_current_step index
    @steps[index][:status] = 'current'
  end

  def is_step_done? step
    @log.include? log_id step
  end

  def index_of_last_step_done
    @steps.index @steps.reverse.find { |x| is_step_done? x }
  rescue
    -1
  end

  def log_id(step)
    case step[:type]
    when 'core_wait_for'
      "core_wait_for[#{@env}#{@nodes[step[:name].to_sym]}]"
    when 'core_set'
      "core_set[#{step[:name]}]"
    else
      step[:full_name]
    end
  end

  def save
    File.open('servers.jsonp', 'w') do |f|
      f.write "servers = #{@servers.to_json};"
    end
  end

end



