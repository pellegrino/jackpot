require 'dm-core'
require 'dm-timestamps'
require 'dm-validations'
require 'dm-aggregates'
require 'dm-migrations'

require_relative '../jackpot'

require_relative 'models/subscription'
require_relative 'models/customer'

# Database
DataMapper.setup(:default, JACKPOT_CONFIG['database'])

DataMapper.auto_migrate! if ENV['RACK_ENV'] == 'development'
