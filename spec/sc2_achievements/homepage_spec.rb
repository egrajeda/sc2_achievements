require 'spec_helper'
require 'sc2_achievements/homepage'

module SC2Achievements
  describe Homepage do
    it 'returns an array with all the achievements in the homepage' do
      VCR.use_cassette('achievements-homepage') do
        achievements = Homepage.get_achievements_for('/3396700/1/Tato')
        achievements.should have_at_least(6).items
        achievements[0].should == {
          :title       => "The Great Train Robbery",
          :description => "Complete all mission objectives in\302\240\342\200\234The Great Train Robbery\342\200\235 mission.",
          :date        => "2012-09-17"
        }
        achievements[5].should == {
          :title       => "The Devil\342\200\231s Playground",
          :description => "Complete all mission objectives in \"The Devil\342\200\231s Playground\342\200\235 mission.",
          :date        => "2012-09-17"
        }
      end
    end

    it 'returns an array with the categories that can be accessed from this page' do
      VCR.use_cassette('achievements-homepage') do
        categories = Homepage.get_categories_for('/3396700/1/Tato')
        categories.should have(7).items
        categories[0].should == "3211280"
        categories[6].should == "4325394"
      end
    end
  end
end