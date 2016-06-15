require 'test_helper'

class ActivityStatusesControllerTest < ActionController::TestCase
  setup do
    @activity_status = activity_statuses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:activity_statuses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create activity_status" do
    assert_difference('ActivityStatus.count') do
      post :create, activity_status: { Activity: @activity_status.Activity, Course_enrollment: @activity_status.Course_enrollment, Status: @activity_status.Status, is_completed: @activity_status.is_completed }
    end

    assert_redirected_to activity_status_path(assigns(:activity_status))
  end

  test "should show activity_status" do
    get :show, id: @activity_status
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @activity_status
    assert_response :success
  end

  test "should update activity_status" do
    patch :update, id: @activity_status, activity_status: { Activity: @activity_status.Activity, Course_enrollment: @activity_status.Course_enrollment, Status: @activity_status.Status, is_completed: @activity_status.is_completed }
    assert_redirected_to activity_status_path(assigns(:activity_status))
  end

  test "should destroy activity_status" do
    assert_difference('ActivityStatus.count', -1) do
      delete :destroy, id: @activity_status
    end

    assert_redirected_to activity_statuses_path
  end
end
