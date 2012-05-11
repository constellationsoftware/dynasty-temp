require 'spec_helper'

describe ResearchController do

  describe "GET 'team'" do
    it "returns http success" do
      get 'team'
      response.should be_success
    end
  end

  describe "GET 'player'" do
    it "returns http success" do
      get 'player'
      response.should be_success
    end
  end

  describe "GET 'news'" do
    it "returns http success" do
      get 'news'
      response.should be_success
    end
  end

  describe "GET 'transactions'" do
    it "returns http success" do
      get 'transactions'
      response.should be_success
    end
  end

  describe "GET 'contracts'" do
    it "returns http success" do
      get 'contracts'
      response.should be_success
    end
  end

  describe "GET 'depth_charts'" do
    it "returns http success" do
      get 'depth_charts'
      response.should be_success
    end
  end

end
