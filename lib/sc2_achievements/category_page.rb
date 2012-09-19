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

  private
    def self.title_of(achievement)
      text_of(achievement, '.desc span')
    end

    def self.description_of(achievement)
      text_of(achievement, '.desc')
    end

    def self.date_of(achievement)
      date = text_of(achievement, '.meta')
      Date.strptime(date, '%m/%d/%Y').strftime('%Y-%m-%d')
    end
  end
end
