require 'date'
require 'sc2_achievements/page'

module SC2Achievements
  class Homepage < Page
    def self.get_achievements_for(user_path)
      page = fetch_page_of user_path
      page.css('#recent-achievements a').each_with_index.inject({}) do |achievements, (achievement, index)|
        achievements[key_for(achievement)] = {
          :title       => title_of(achievement),
          :description => description_of(achievement),
          :date        => date_of(achievement),
          :recentness  => index + 1 }
        achievements
      end
    end

  private
    # TODO: in the future we might use a real ID, checksum, etc.
    def self.key_for(achievement)
      title_of(achievement)
    end

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
