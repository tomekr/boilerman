require 'test_helper'

module Boilerman
  class ControllersControllerTest < ActionController::TestCase
    test "should get index" do
      get :index
      assert_response :success
    end

  end
end
