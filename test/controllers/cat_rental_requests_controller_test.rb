require 'test_helper'

class CatRentalRequestsControllerTest < ActionController::TestCase
  setup do
    @cat_rental_request = cat_rental_requests(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cat_rental_requests)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cat_rental_request" do
    assert_difference('CatRentalRequest.count') do
      post :create, cat_rental_request: { cat_id: @cat_rental_request.cat_id, end_date: @cat_rental_request.end_date, start_date: @cat_rental_request.start_date }
    end

    assert_redirected_to cat_rental_request_path(assigns(:cat_rental_request))
  end

  test "should show cat_rental_request" do
    get :show, id: @cat_rental_request
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @cat_rental_request
    assert_response :success
  end

  test "should update cat_rental_request" do
    patch :update, id: @cat_rental_request, cat_rental_request: { cat_id: @cat_rental_request.cat_id, end_date: @cat_rental_request.end_date, start_date: @cat_rental_request.start_date }
    assert_redirected_to cat_rental_request_path(assigns(:cat_rental_request))
  end

  test "should destroy cat_rental_request" do
    assert_difference('CatRentalRequest.count', -1) do
      delete :destroy, id: @cat_rental_request
    end

    assert_redirected_to cat_rental_requests_path
  end
end
