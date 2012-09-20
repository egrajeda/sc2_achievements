require 'spec_helper'
require 'sc2_achievements/homepage'

module SC2Achievements
  describe Homepage do
    it 'returns an array with all the achievements in the homepage' do
      VCR.use_cassette('achievements-homepage') do
        achievements = Page.get_achievements_for '/3396700/1/Tato'
        achievements.should have(6).items
        achievements["Matt Horner Missions"].should == {
          :title       => "Matt Horner Missions",
          :description => "Complete the Horner storyline in the Wings of Liberty campaign.",
          :date        => "2012-09-19",
          :recentness  => 1
        }
        achievements["Breakout"].should == {
          :title       => "Breakout",
          :description => "Complete all mission objectives in the\302\240\342\200\234Breakout\342\200\235 mission.",
          :date        => "2012-09-19",
          :recentness  => 6
        }
      end
    end
  end
end
