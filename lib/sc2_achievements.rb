# encoding: UTF-8
require 'nokogiri'
require 'open-uri'

module SC2Achievements
  class << self
    def self.for(user_path)
      recent_achievements_of(user_path)
    end

  private
    def self.path_for(user_path)
      "http://battle.net/sc2/en/profile#{user_path}/achievements/"
    end

    def self.recent_achievements_of(user_path)
      achievements = []
      page = fetch_page(path_for(user_path))
      page.css('#recent-achievements a').each do |achievement|
        description = extract_text_of(achievement.attr('data-tooltip'))
        date = Date.strptime(achievement.css('span').text.strip, '%m/%d/%Y')
        achievements.push({
          :title       => achievement.xpath('text()').text.strip,
          :description => description,
          :date        => date.strftime('%Y-%m-%d')
        })
      end
      achievements
    end

    def self.fetch_page(path)
      html = open(path).read
      @current_page = Nokogiri::HTML(html)
    end

    def self.extract_text_of(css)
      @current_page.css(css).xpath('text()').text.strip
    end
  end
end
