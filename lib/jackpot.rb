require_relative 'jackpot/version'


raw_config = File.read(File.dirname(__FILE__) + "/../config/jackpot.yml")
JACKPOT_CONFIG = YAML.load(raw_config)[ENV['RACK_ENV']]

