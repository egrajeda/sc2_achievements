require 'spec_helper'
require 'sc2_achievements/category_page'

module SC2Achievements
  describe CategoryPage do
    it 'returns an array with all the achievements earned in that page' do
      VCR.use_cassette('mar-sara-missions') do
        achievements = Page.get_achievements_for '/3396700/1/Tato', :category => 3211280
        achievements.should have(5).items
        achievements["Liberation Day"].should == {
          :title       => "Liberation Day",
          :description => "Complete all mission objectives in the\302\240\342\200\234Liberation Day\342\200\235 mission.",
          :category    => "Mar Sara Missions",
          :points      => 15,
          :date        => "2012-09-17"
        }
        achievements["Hold the Line"].should == {
          :title       => "Hold the Line",
          :description => "Complete the\302\240\342\200\234Zero Hour\342\200\235 mission on Normal difficulty without losing or salvaging a structure.",
          :category    => "Mar Sara Missions",
          :points      => 10,
          :date        => "2012-09-17"
        }
      end
    end
  end
end
