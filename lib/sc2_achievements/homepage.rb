require 'date'
require 'sc2_achievements/page'

module SC2Achievements
  class Homepage < Page
    def self.get_achievements_for(user_path)
      page = fetch_homepage_of(user_path)
      page.css('#recent-achievements a').collect do |achievement|
        { :title       => title_of(achievement),
          :description => description_of(achievement),
          :date        => date_of(achievement) }
      end
    end

  private
    def self.title_of(achievement)
      achievement.xpath('text()').text.strip
    end

    def self.description_of(achievement)
      achievement.parent.css(achievement.attr('data-tooltip')).xpath('text()').text.strip
    end

    def self.date_of(achievement)
      Date.strptime(achievement.css('span').text.strip, '%m/%d/%Y').strftime('%Y-%m-%d')
    end
  end
end
