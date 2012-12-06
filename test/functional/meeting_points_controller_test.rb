require 'test_helper'

class MeetingPointsControllerTest < ActionController::TestCase
  setup do
    @meeting_point = meeting_points(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:meeting_points)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create meeting_point" do
    assert_difference('MeetingPoint.count') do
      post :create, meeting_point: {  }
    end

    assert_redirected_to meeting_point_path(assigns(:meeting_point))
  end

  test "should show meeting_point" do
    get :show, id: @meeting_point
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @meeting_point
    assert_response :success
  end

  test "should update meeting_point" do
    put :update, id: @meeting_point, meeting_point: {  }
    assert_redirected_to meeting_point_path(assigns(:meeting_point))
  end

  test "should destroy meeting_point" do
    assert_difference('MeetingPoint.count', -1) do
      delete :destroy, id: @meeting_point
    end

    assert_redirected_to meeting_points_path
  end
end
