require 'date'
require 'sc2_achievements/page'

module SC2Achievements
  class Homepage < Page
    def self.get_achievements_for(user_path)
      page = fetch_page_of user_path
      page.css('#recent-achievements a').collect do |achievement|
        { :title       => title_of(achievement),
          :description => description_of(achievement),
          :date        => date_of(achievement) }
      end
    end

    def self.get_categories_for(user_path)
      page = fetch_page_of user_path
      page.css('#profile-menu a[href*=category]').collect do |achievement|
        achievement.attr('href')[/category\/(.*)/, 1]
      end
    end

  private
    def self.title_of(achievement)
      text_of(achievement)
    end

    def self.description_of(achievement)
      text_of(achievement.parent, achievement.attr('data-tooltip'))
    end

    def self.date_of(achievement)
      date_from(achievement, 'span')
    end
  end
end