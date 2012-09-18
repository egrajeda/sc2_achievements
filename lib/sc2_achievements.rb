require 'nokogiri'
require 'open-uri'
require 'sc2_achievements/homepage'

module SC2Achievements
  def self.for(user_path)
    Homepage.get_achievements_for(user_path)
  end
end
