require 'nokogiri'
require 'open-uri'

module SC2Achievements
  class Page
  protected
    def self.fetch_page_of(user_path, options = {})
      if options.has_key? :category
        path = "http://battle.net/sc2/en/profile#{user_path}/achievements/category/#{options[:category]}"
      else
        path = "http://battle.net/sc2/en/profile#{user_path}/achievements/"
      end
      html = open(path).read
      Nokogiri::HTML(html)
    end

    def self.text_of(current_node, css_selector=nil)
      if css_selector
        current_node = current_node.css(css_selector)
      end
      current_node.xpath('text()').text.strip
    end
  end
end
