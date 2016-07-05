require 'test_helper'

class CourseEnrollmentsControllerTest < ActionController::TestCase
  setup do
    @course_enrollment = course_enrollments(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:course_enrollments)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create course_enrollment" do
    assert_difference('CourseEnrollment.count') do
      post :create, course_enrollment: { active: @course_enrollment.active, completed: @course_enrollment.completed, course_id: @course_enrollment.course_id, is_visible: @course_enrollment.is_visible, is_visible_friends: @course_enrollment.is_visible_friends, user_id: @course_enrollment.user_id }
    end

    assert_redirected_to course_enrollment_path(assigns(:course_enrollment))
  end

  test "should show course_enrollment" do
    get :show, id: @course_enrollment
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @course_enrollment
    assert_response :success
  end

  test "should update course_enrollment" do
    patch :update, id: @course_enrollment, course_enrollment: { active: @course_enrollment.active, completed: @course_enrollment.completed, course_id: @course_enrollment.course_id, is_visible: @course_enrollment.is_visible, is_visible_friends: @course_enrollment.is_visible_friends, user_id: @course_enrollment.user_id }
    assert_redirected_to course_enrollment_path(assigns(:course_enrollment))
  end

  test "should destroy course_enrollment" do
    assert_difference('CourseEnrollment.count', -1) do
      delete :destroy, id: @course_enrollment
    end

    assert_redirected_to course_enrollments_path
  end
end
