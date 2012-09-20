require 'nokogiri'
require 'open-uri'
require 'sc2_achievements/homepage'
require 'sc2_achievements/category_page'

module SC2Achievements
  def self.for(user_path)
    achievements = get_achievements_for user_path
    achievements.sort_by do |title, achievement|
      [achievement[:recentness] || 7, achievement[:date]]
    end.collect do |achievement|
      achievement[1].delete :recentness
      achievement[1]
    end
  end

private
  def self.get_achievements_for(user_path)
    achievements = Page.get_achievements_for user_path
    Page.get_categories_for(user_path).inject(achievements) do |achievements, category|
      category_achievements = Page.get_achievements_for(user_path, :category => category)
      achievements.merge(category_achievements) do |title, old, new|
        old.merge(new)
      end
    end
  end

end
