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

    def navbar_entry(name, options = {}, html_options = {}, &block)
      if current_page?(options) 
        content_tag("li", class: "active")  { link_to(name, options, html_options, &block) } 
      else
        content_tag("li")                   { link_to(name, options, html_options, &block) }
      end 
    end 
  end

end
