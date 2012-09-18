require 'nokogiri'
require 'open-uri'

module SC2Achievements
  class Page
  protected
    def self.fetch_homepage_of(user_path)
      path = "http://battle.net/sc2/en/profile#{user_path}/achievements/"
      html = open(path).read
      @current_page = Nokogiri::HTML(html)
    end
  end
end
