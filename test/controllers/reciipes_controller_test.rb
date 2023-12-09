require 'test_helper'

class ReciipesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @reciipe = reciipes(:one)
  end

  test 'should get index' do
    get reciipes_url
    assert_response :success
  end

  test 'should get new' do
    get new_reciipe_url
    assert_response :success
  end

  test 'should create reciipe' do
    assert_difference('Reciipe.count') do
      post reciipes_url,
           params: { reciipe: { cooking_time: @reciipe.cooking_time, description: @reciipe.description, name: @reciipe.name,
                                preparation_time: @reciipe.preparation_time, public: @reciipe.public, user_id: @reciipe.user_id } }
    end

    assert_redirected_to reciipe_url(Reciipe.last)
  end

  test 'should show reciipe' do
    get reciipe_url(@reciipe)
    assert_response :success
  end

  test 'should get edit' do
    get edit_reciipe_url(@reciipe)
    assert_response :success
  end

  test 'should update reciipe' do
    patch reciipe_url(@reciipe),
          params: { reciipe: { cooking_time: @reciipe.cooking_time, description: @reciipe.description, name: @reciipe.name,
                               preparation_time: @reciipe.preparation_time, public: @reciipe.public, user_id: @reciipe.user_id } }
    assert_redirected_to reciipe_url(@reciipe)
  end

  test 'should destroy reciipe' do
    assert_difference('Reciipe.count', -1) do
      delete reciipe_url(@reciipe)
    end

    assert_redirected_to reciipes_url
  end
end
