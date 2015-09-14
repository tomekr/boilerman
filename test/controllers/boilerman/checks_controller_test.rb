require 'test_helper'

module Boilerman
  class ChecksControllerTest < ActionController::TestCase
    test "should get inheritance_check" do
      get :inheritance_check
      assert_response :success
    end

    test "should get index" do
      get :index
      assert_response :success
    end

    test "should get csrf" do
      get :csrf
      assert_response :success
    end

  end
end
