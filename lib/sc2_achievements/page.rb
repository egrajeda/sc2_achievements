require 'nokogiri'
require 'open-uri'

module SC2Achievements
  class Page
    def self.get_achievements_for(user_path, options = {})
      if options.has_key? :category
        CategoryPage.get_achievements_for user_path, options[:category]
      else
        Homepage.get_achievements_for user_path
      end
    end

    def self.get_categories_for(user_path, options = {})
      page = fetch_page_of user_path, options
      page.css('#profile-menu a[href*=category]').collect do |achievement|
        achievement.attr('href')[/category\/(.*)/, 1]
      end
    end

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

    def self.date_from(current_node, css_selector=nil)
      date = text_of(current_node, css_selector)
      Date.strptime(date, '%m/%d/%Y').strftime('%Y-%m-%d')
    end
  end
end
