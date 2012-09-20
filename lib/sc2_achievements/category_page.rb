require 'sc2_achievements/page'

module SC2Achievements
  class CategoryPage < Page
    def self.get_achievements_for(user_path, category)
      page = fetch_page_of user_path, :category => category
      page.css('.achievement.earned').collect do |achievement|
        { :title       => title_of(achievement),
          :description => description_of(achievement),
          :date        => date_of(achievement) }
      end
    end

    def self.get_categories_for(user_path, category)
      page = fetch_page_of user_path, :category => category
      page.css('#profile-menu a[href*=category]').collect do |achievement|
        achievement.attr('href')[/category\/(.*)/, 1]
      end
    end

  private
    def self.title_of(achievement)
      text_of(achievement, '.desc span')
    end

    def self.description_of(achievement)
      text_of(achievement, '.desc')
    end

    def self.date_of(achievement)
      date_from(achievement, '.meta')
    end
  end
end
