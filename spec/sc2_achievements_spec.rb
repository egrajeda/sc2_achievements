require 'spec_helper'
require 'sc2_achievements'

describe SC2Achievements do
  it 'add the recently earned achievements to the top' do
    SC2Achievements::Page.stub(:get_categories_for) { [] }
    VCR.use_cassette('achievements-homepage') do
      achievements = SC2Achievements.for('/3396700/1/Tato')
      achievements.should have(6).items
      achievements[0].should == {
        :title       => "That\342\200\231s Teamwork",
        :description => "Win 5 Team league Quick Match games.",
        :date        => "2012-09-20"
      }
      achievements[5].should == {
        :title       => "Semi-Glorious",
        :description => "Kill 250 additional Zerg units in the\302\240\342\200\234In Utter Darkness\342\200\235 mission on Normal difficulty.",
        :date        => "2012-09-20"
      }
    end
  end

  it 'gets the achievements from the first group of categories' do
    SC2Achievements::Page.stub(:get_categories_for) { [3211280, 3211281] }
    VCR.use_cassette('achievements-homepage-and-first-categories') do
      achievements = SC2Achievements.for('/3396700/1/Tato')
      achievements.should have(16).items
      achievements[0][:title].should == "That\342\200\231s Teamwork"
      achievements[5][:title].should == "Semi-Glorious"
    end
  end

  it "doesn't duplicate achievements that are on the homepage" do
    SC2Achievements::Page.stub(:get_categories_for) { [4325400] }
    VCR.use_cassette('achievements-homepage-and-guide-three') do
      achievements = SC2Achievements.for('/3396700/1/Tato')
      achievements.should have(7).items
      achievements[0][:title].should == "That\342\200\231s Teamwork"
      achievements[5][:title].should == "Semi-Glorious"
      achievements[6][:date].should == "2012-05-07"
    end
  end
end
