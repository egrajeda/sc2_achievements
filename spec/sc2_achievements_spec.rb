require 'spec_helper'
require 'sc2_achievements'

describe SC2Achievements do
  it 'add the recently earned achievements to the top' do
    VCR.use_cassette('achievements-homepage') do
      achievements = SC2Achievements.for('/3396700/1/Tato')
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
end
