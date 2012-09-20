require 'spec_helper'
require 'sc2_achievements'

describe SC2Achievements do
  it 'add the recently earned achievements to the top' do
    SC2Achievements::Page.stub(:get_categories_for) { [] }
    VCR.use_cassette('achievements-homepage') do
      achievements = SC2Achievements.for('/3396700/1/Tato')
      achievements.should have(6).items
      achievements[0].should == {
        :title       => "Matt Horner Missions",
        :description => "Complete the Horner storyline in the Wings of Liberty campaign.",
        :date        => "2012-09-19"
      }
      achievements[5].should == {
        :title       => "Breakout",
        :description => "Complete all mission objectives in the\302\240\342\200\234Breakout\342\200\235 mission.",
        :date        => "2012-09-19"
      }
    end
  end

  it 'gets the achievements from the first group of categories' do
    SC2Achievements::Page.stub(:get_categories_for) { [3211280, 3211281] }
    VCR.use_cassette('achievements-homepage-and-first-categories') do
      achievements = SC2Achievements.for('/3396700/1/Tato')
      achievements.should have(16).items
      achievements[0][:title].should == "Matt Horner Missions"
      achievements[5][:title].should == "Breakout"
    end
  end

  it "doesn't duplicate achievements that are on the homepage" do
    SC2Achievements::Page.stub(:get_categories_for) { [3211282] }
    VCR.use_cassette('achievements-homepage-and-covert-missions') do
      achievements = SC2Achievements.for('/3396700/1/Tato')
      achievements.should have(8).items
      achievements[0][:title].should == "Matt Horner Missions"
      achievements[5][:title].should == "Breakout"
      achievements[6][:date].should == "2012-09-17"
      achievements[7][:date].should == "2012-09-17"
    end
  end
end
