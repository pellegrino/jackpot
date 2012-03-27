module Jackpot
  module ApplicationHelper
    def twitterized_type(type)
      case type
      when :alert
        "alert"
      when :error
        "alert alert-error"
      when :notice
        "alert alert-success"
      when :info
        "alert alert-info"
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


    def gravatar_for_current_user options = {}
      options = {:alt => 'avatar', :class => 'avatar', :size => 80}.merge! options
      id = Digest::MD5::hexdigest current_user.email.strip.downcase
      url = 'http://www.gravatar.com/avatar/' + id + '.jpg?s=' + options[:size].to_s
      options.delete :size
      image_tag url, options
    end

    def jackpot_gateway
      Jackpot.configuration.gateway["type"].to_s.humanize
    end 
    def jackpot_gateway_mode
      Jackpot.configuration.gateway["mode"].to_s.humanize
    end 

  end


end
