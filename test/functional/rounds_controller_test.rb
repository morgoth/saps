require 'test_helper'

class RoundsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:rounds)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_round
    assert_difference('Round.count') do
      post :create, :round => { }
    end

    assert_redirected_to round_path(assigns(:round))
  end

  def test_should_show_round
    get :show, :id => rounds(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => rounds(:one).id
    assert_response :success
  end

  def test_should_update_round
    put :update, :id => rounds(:one).id, :round => { }
    assert_redirected_to round_path(assigns(:round))
  end

  def test_should_destroy_round
    assert_difference('Round.count', -1) do
      delete :destroy, :id => rounds(:one).id
    end

    assert_redirected_to rounds_path
  end
end
