require 'sc2_achievements/homepage'
require 'sc2_achievements/category_page'

module SC2Achievements
  def self.for(user_path)
    achievements = get_achievements_for user_path
    achievements.sort_by do |title, achievement|
      [achievement[:date], -(achievement[:recentness] || 7)]
    end.reverse.collect do |title, achievement|
      achievement.delete :recentness
      achievement
    end
  end

private
  def self.get_achievements_for(user_path)
    achievements = Page.get_achievements_for user_path
    Page.get_categories_for(user_path).inject(achievements) do |achievements, category|
      add_subcategories_achievements_to(achievements, user_path, category)
    end
  end

  def self.add_subcategories_achievements_to(achievements, user_path, category)
    Page.get_categories_for(user_path, :category => category).inject(achievements) do |achievements, category|
      category_achievements = Page.get_achievements_for(user_path, :category => category)
      achievements.merge(category_achievements) do |title, old_achievement, new_achievement|
        old_achievement.merge(new_achievement)
      end
    end
  end

end
