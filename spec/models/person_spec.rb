require 'spec_helper'

describe Person do

  before :all do
    clean_database
    FactoryGirl.reload
    @user = FactoryGirl.create(:user)
    @person = FactoryGirl.create(:person)
    @profile = @person.create_profile
    @person.owner = @user

  end

  describe :SocialSubject do
    it "should be a voter" do
      @person.should be_voter
    end

    it "should be a commenter" do
      @person.should be_commenter
    end

    it "should be a favouriter" do
      @person.should be_favouriter
    end

    it "should be tagger" do
      @person.should be_tagger
    end
  end

  it "should have a profile" do
    @person.profile.should == @profile
  end

end
