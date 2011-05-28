require_relative 'clients'

module Jackpot
  module Console
    require 'irb'
    require 'irb/completion'
    extend self

    def start
      ARGV.shift

      IRB.start
    end
  end
end
