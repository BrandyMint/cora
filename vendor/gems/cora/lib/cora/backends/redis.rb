class Cora::Backends::Redis
  attr_reader :redis

  def initialize
    r = Redis.new #$(:host => '127.0.0.1', :port => 6379)
    @redis = Redis::Namespace.new Cora.namespace, :redis => r

    Redis::Objects.redis = @redis
  end

  def get key
    redis.get key
  end

  def set key, content
    redis.set key, content
  end

  # Список всех ключей элементов
  def element_keys ns=[]
    ns = [ns] unless ns.is_a? Array
    ns << '*'
    redis.keys ns.join(':')
  end

end
