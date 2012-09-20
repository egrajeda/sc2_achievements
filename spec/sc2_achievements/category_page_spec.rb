require 'spec_helper'
require 'sc2_achievements/category_page'

module SC2Achievements
  describe CategoryPage do
    it 'returns an array with all the achievements earned in that page' do
      VCR.use_cassette('mar-sara-missions') do
        achievements = CategoryPage.get_achievements_for('/3396700/1/Tato', 3211280)
        achievements.should have_at_least(5).items
        achievements[0].should == {
          :title       => "Liberation Day",
          :description => "Complete all mission objectives in the\302\240\342\200\234Liberation Day\342\200\235 mission.",
          :date        => "2012-09-17"
        }
        achievements[4].should == {
          :title       => "Hold the Line",
          :description => "Complete the\302\240\342\200\234Zero Hour\342\200\235 mission on Normal difficulty without losing or salvaging a structure.",
          :date        => "2012-09-17"
        }
      end
    end
  end
end
