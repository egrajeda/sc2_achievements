require 'sc2_achievements/page'

module SC2Achievements
  class CategoryPage < Page
    def self.get_achievements_for(user_path, category)
      page = fetch_page_of user_path, :category => category
      achievements = page.css('.achievement.earned').inject({}) do |achievements, achievement|
        achievements[key_for(achievement)] = {
          :title       => title_of(achievement),
          :description => description_of(achievement),
          :category    => category_of(achievement),
          :points      => points_of(achievement),
          :date        => date_of(achievement) }
        achievements
      end
      achievements = page.css('.series-tile:not(.tile-locked)').inject(achievements) do |achievements, achievement|
        achievements[key_for(achievement)] = {
          :title       => title_of(achievement),
          :description => description_of(achievement),
          :category    => category_of(achievement),
          :points      => points_of(achievement),
          :date        => date_of(achievement) }
        achievements
      end
    end

  private
    # See Homepage.key_for
    def self.key_for(achievement)
      title_of(achievement)
    end

    def self.title_of(achievement)
      if achievement.attr('class') =~ /series-tile/
        text_of(achievement, achievement.attr('data-tooltip') + ' .tooltip-title')
      else
        text_of(achievement, '.desc span')
      end
    end

    def self.description_of(achievement)
      if achievement.attr('class') =~ /series-tile/
        text_of(achievement, achievement.attr('data-tooltip'))
      else
        text_of(achievement, '.desc')
      end
    end

    def self.category_of(achievement)
      wrapper = achievement.ancestors('#profile-wrapper')
      text_of(wrapper, '#profile-menu .active a')
    end

    def self.points_of(achievement)
      if achievement.attr('class') =~ /series-tile/
        text_of(achievement, '.series-badge').to_i
      else
        text_of(achievement, '.meta span').to_i
      end
    end

    def self.date_of(achievement)
      if achievement.attr('class') =~ /series-tile/
        achievement = achievement.ancestors('.achievement')
      end
      date_from(achievement, '.meta')
    end
  end
end
