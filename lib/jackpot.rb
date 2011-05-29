require_relative 'jackpot/version'

raw_config = File.read(File.dirname(__FILE__) + "/../config/jackpot.yml")
raise "Configuration file not found. Check if /config/jackpot.yml exists" if raw_config.nil?
JACKPOT_CONFIG = YAML.load(raw_config)[ENV['RACK_ENV']]

