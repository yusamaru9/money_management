require "test_helper"

class MonthRecordsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get month_records_index_url
    assert_response :success
  end

  test "should get new" do
    get month_records_new_url
    assert_response :success
  end

  test "should get show" do
    get month_records_show_url
    assert_response :success
  end

  test "should get edit" do
    get month_records_edit_url
    assert_response :success
  end
end
