require 'test_helper'

class CategoriesControllerTest < ActionController::TestCase

  def setup
    @category = Category.create(name: 'sports')
    @user = User.create(username: 'John', email: 'john@example.com', password: 'password', admin: true)
  end

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get new" do
    session[:user_id] = @user.id
    # sign_in_as(@user, "password") - this does not work since needs ActionDispatch
    get :new
    assert_response :success
  end

  test "should get show" do
    get(:show, params: {'id' => @category.id})
    assert_response :success
  end

  test "should redirect when admin not logged in" do
    assert_no_difference 'Category.count' do
      post :create, category: { name: 'sports'}
    end
    assert_redirected_to categories_path
  end
end