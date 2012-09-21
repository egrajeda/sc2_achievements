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

  it "goes and fetch the achievements for all the categories on the page" do
    user_path = '/3396700/1/Tato'
    SC2Achievements::Page.stub(:get_categories_for).with(user_path) { [3211280, 4325398] }
    SC2Achievements::Page.stub(:get_categories_for).with(user_path, :category => 3211280) { [3211280, 3211281] }
    SC2Achievements::Page.stub(:get_categories_for).with(user_path, :category => 3211281) { [3211280, 3211281] }
    SC2Achievements::Page.stub(:get_categories_for).with(user_path, :category => 4325398) { [4325398, 4325400] }
    SC2Achievements::Page.stub(:get_categories_for).with(user_path, :category => 4325398) { [4325400, 4325400] }
    VCR.use_cassette('all-selected-achievements') do
      achievements = SC2Achievements.for(user_path)
      achievements.should have(17).items
      achievements[0][:title].should == "That\342\200\231s Teamwork"
      achievements[5][:title].should == "Semi-Glorious"
      achievements[6][:date].should == "2012-09-17"
      achievements[15][:date].should == "2012-09-17"
      achievements[16][:date].should == "2012-05-07"
    end
  end

  it "orders all the achievements according to the date and its 'recentness'" do
    VCR.use_cassette('all-achievements') do
      achievements = SC2Achievements.for('/3396700/1/Tato')
      achievements.should have(51).items
      for i in 1..(achievements.length - 1)
        (achievements[i - 1][:date] <=> achievements[i][:date]).should_not == -1
      end
      achievements[0][:title].should == "That\342\200\231s Teamwork"
      achievements[5][:title].should == "Semi-Glorious"
    end
  end

  xit "returns an empty array if there is no achievements" do
  end

  xit "it specifies the category" do
  end

  xit "it specifies the points earned" do
  end
end
