require 'data_mapper'

env = ENV['RACK_ENV'] || 'development'

# we're telling datamapper to use a postgres database on localhost. The name will be "bookmark_manager_test" or "bookmark_manager_development" depending on the environment
DataMapper.setup(:default, ENV['postgres://mvwihxoqlohpjo:6L7icTjGTR8RlsfVaeho0jxzsn@ec2-107-22-249-138.compute-1.amazonaws.com:5432/d25j3hjqkncbkb' || "postgres://localhost/bookmark_manager_#{env}")

require './app/models/link' # require each model individually - the path may vary depending on your file structure.

# After declaring your models, you should finalise them
DataMapper.finalize

# However, the database tables don't exist yet. Let's tell datamapper to create them
DataMapper.auto_upgrade!