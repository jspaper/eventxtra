require 'nest'

$redis = Redis.new(:host => "127.0.0.1", :port => 6379, :logger => Rails.logger)

ActiveRecord::Base.class_eval do

  def rdb
    Nest.new(self.class.name, $redis)[to_param]
  end

  def self.rdb
    Nest.new(name, $redis)
  end
end

