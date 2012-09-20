require 'spec_helper'
require 'sc2_achievements'

describe SC2Achievements do
  it 'add the recently earned achievements to the top' do
    SC2Achievements::Page.stub(:get_categories_for) { [] }
    VCR.use_cassette('achievements-homepage') do
      achievements = SC2Achievements.for('/3396700/1/Tato')
      achievements.should have(6).items
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

  it 'gets the achievements from the first group of categories' do
    SC2Achievements::Page.stub(:get_categories_for) { [3211280, 3211281] }
    VCR.use_cassette('achievements-homepage-and-first-categories') do
      achievements = SC2Achievements.for('/3396700/1/Tato')
      achievements.should have(16).items
    end
  end

#  it "doesn't duplicate achievements that are on the homepage" do
#    SC2Achievements::Page.stub(:get_categories_for) { [3211282] }
#    VCR.use_cassette('achievements-homepage-and-covert-missions') do
#      achievements = SC2Achievements.for('/3396700/1/Tato')
#      achievements.should have(8).items
#    end
#  end
end
