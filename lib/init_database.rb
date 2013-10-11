
require 'dm-core'

require 'dm-migrations'
require 'dm-serializer'
require 'dm-timestamps'
require 'dm-transactions'
require 'dm-types'
require 'dm-validations'

root_dir = File.expand_path(File.join(File.dirname(__FILE__), '..'))

DataMapper::Logger.new($stdout, :info)
DataMapper.setup(:default, "sqlite://#{root_dir}/config/database.db")

Dir[File.join(root_dir, 'models', '*.rb')].each do |m|
  require "models/#{File.basename(m, '.rb')}"
end

DataMapper.finalize

