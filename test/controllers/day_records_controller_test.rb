require "test_helper"

class DayRecordsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get day_records_index_url
    assert_response :success
  end

  test "should get new" do
    get day_records_new_url
    assert_response :success
  end

  test "should get show" do
    get day_records_show_url
    assert_response :success
  end

  test "should get edit" do
    get day_records_edit_url
    assert_response :success
  end
end
