module Jackpot
  module ApplicationHelper
    def twitterized_type(type)
      case type
      when :alert
        "warning"
      when :error
        "error"
      when :notice
        "success"
      when :info
        "info"
      else
        type.to_s
      end
    end
  end
end
