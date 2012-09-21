require 'sc2_achievements/page'

module SC2Achievements
  class CategoryPage < Page
    def self.get_achievements_for(user_path, category)
      page = fetch_page_of user_path, :category => category
      page.css('.achievement.earned').inject({}) do |achievements, achievement|
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
      text_of(achievement, '.desc span')
    end

    def self.description_of(achievement)
      text_of(achievement, '.desc')
    end

    def self.category_of(achievement)
      wrapper = achievement.ancestors('#profile-wrapper')
      text_of(wrapper, '#profile-menu .active a')
    end

    def self.points_of(achievement)
      text_of(achievement, '.meta span').to_i
    end

    def self.date_of(achievement)
      date_from(achievement, '.meta')
    end
  end
end
