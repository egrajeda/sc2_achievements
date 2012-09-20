require 'nokogiri'
require 'open-uri'
require 'sc2_achievements/homepage'
require 'sc2_achievements/category_page'

module SC2Achievements
  def self.for(user_path)
    achievements = Page.get_achievements_for user_path
    Page.get_categories_for(user_path).each do |category|
      achievements += Page.get_achievements_for user_path, :category => category
    end
    achievements
  end
end
