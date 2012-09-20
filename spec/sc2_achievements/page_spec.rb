require 'spec_helper'
require 'sc2_achievements/page'

module SC2Achievements
  describe Page do
    it 'returns an array with the categories that can be accessed from the homepage' do
      VCR.use_cassette('achievements-homepage') do
        categories = Page.get_categories_for '/3396700/1/Tato'
        categories.should have(7).items
        categories[0].should == "3211280"
        categories[6].should == "4325394"
      end
    end

    it 'returns an array with the categories that can be accessed from a category page' do
      VCR.use_cassette('mar-sara-missions') do
        categories = Page.get_categories_for '/3396700/1/Tato', :category => 3211280
        categories.should have(8).items
        categories[0].should == "3211280"
        categories[7].should == "3211287"
      end
    end
  end
end
