# Load Redis configuration with ERB evaluation
redis_yml = ERB.new(File.read(Rails.root.join("config/redis.yml"))).result
REDIS_CONFIG = YAML.safe_load(redis_yml, aliases: true, symbolize_names: true)

# Get default configuration
dflt = REDIS_CONFIG[:default] || {}

# Merge with environment-specific configuration
env_config = REDIS_CONFIG[Rails.env.to_sym] || {}
$redis_config = dflt.merge(env_config)

# Initialize Redis connection
$redis = Redis.new($redis_config)
