require 'nokogiri'
require 'open-uri'
require 'sc2_achievements/page'

module SC2Achievements
  def self.for(user_path)
    Page.get_achievements_for user_path 
  end
end
