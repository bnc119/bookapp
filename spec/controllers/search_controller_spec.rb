require 'spec_helper'

describe SearchController do
  
  describe "GET 'index'" do
    it "should be successful" do
      get 'index'
      response.should be_success
    end
    
    it "should return the results of a search" do
      
    end
    
  end
  
end
