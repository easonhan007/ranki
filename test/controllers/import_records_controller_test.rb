require "test_helper"

class ImportRecordsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @import_record = import_records(:one)
  end

  test "should get index" do
    get import_records_url
    assert_response :success
  end

  test "should get new" do
    get new_import_record_url
    assert_response :success
  end

  test "should create import_record" do
    assert_difference("ImportRecord.count") do
      post import_records_url, params: { import_record: { csv: @import_record.csv, success: @import_record.success, user_id: @import_record.user_id } }
    end

    assert_redirected_to import_record_url(ImportRecord.last)
  end

  test "should show import_record" do
    get import_record_url(@import_record)
    assert_response :success
  end

  test "should get edit" do
    get edit_import_record_url(@import_record)
    assert_response :success
  end

  test "should update import_record" do
    patch import_record_url(@import_record), params: { import_record: { csv: @import_record.csv, success: @import_record.success, user_id: @import_record.user_id } }
    assert_redirected_to import_record_url(@import_record)
  end

  test "should destroy import_record" do
    assert_difference("ImportRecord.count", -1) do
      delete import_record_url(@import_record)
    end

    assert_redirected_to import_records_url
  end
end
