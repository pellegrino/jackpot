require 'dm-core'
require 'dm-timestamps'
require 'dm-validations'
require 'dm-aggregates'
require 'dm-migrations'

require_relative 'models/subscription'
require_relative 'models/customer'

raw_config = File.read(File.dirname(__FILE__) + "/../../jackpot.yml")
JACKPOT_CONFIG = YAML.load(raw_config)[ENV['RACK_ENV']]
# Database
DataMapper.setup(:default, JACKPOT_CONFIG['database'])

DataMapper.auto_migrate! if ENV['RACK_ENV'] == 'development'
