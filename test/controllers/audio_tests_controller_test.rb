require 'test_helper'

class AudioTestsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @audio_test = audio_tests(:one)
  end

  test "should get index" do
    get audio_tests_url
    assert_response :success
  end

  test "should get new" do
    get new_audio_test_url
    assert_response :success
  end

  test "should create audio_test" do
    assert_difference('AudioTest.count') do
      post audio_tests_url, params: { audio_test: {  } }
    end

    assert_redirected_to audio_test_url(AudioTest.last)
  end

  test "should show audio_test" do
    get audio_test_url(@audio_test)
    assert_response :success
  end

  test "should get edit" do
    get edit_audio_test_url(@audio_test)
    assert_response :success
  end

  test "should update audio_test" do
    patch audio_test_url(@audio_test), params: { audio_test: {  } }
    assert_redirected_to audio_test_url(@audio_test)
  end

  test "should destroy audio_test" do
    assert_difference('AudioTest.count', -1) do
      delete audio_test_url(@audio_test)
    end

    assert_redirected_to audio_tests_url
  end
end
