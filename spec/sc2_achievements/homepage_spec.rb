require 'spec_helper'
require 'sc2_achievements/homepage'

module SC2Achievements
  describe Homepage do
    it 'returns an array with all the achievements in the homepage' do
      VCR.use_cassette('achievements-homepage') do
        achievements = Page.get_achievements_for '/3396700/1/Tato'
        achievements.should have(6).items
        achievements["That\342\200\231s Teamwork"].should == {
          :title       => "That\342\200\231s Teamwork",
          :description => "Win 5 Team league Quick Match games.",
          :date        => "2012-09-20",
          :recentness  => 1
        }
        achievements["Semi-Glorious"].should == {
          :title       => "Semi-Glorious",
          :description => "Kill 250 additional Zerg units in the\302\240\342\200\234In Utter Darkness\342\200\235 mission on Normal difficulty.",
          :date        => "2012-09-20",
          :recentness  => 6
        }
      end
    end
  end
end
