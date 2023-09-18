require "application_system_test_case"

class ImportRecordsTest < ApplicationSystemTestCase
  setup do
    @import_record = import_records(:one)
  end

  test "visiting the index" do
    visit import_records_url
    assert_selector "h1", text: "Import records"
  end

  test "should create import record" do
    visit import_records_url
    click_on "New import record"

    fill_in "Csv", with: @import_record.csv
    fill_in "Success", with: @import_record.success
    fill_in "User", with: @import_record.user_id
    click_on "Create Import record"

    assert_text "Import record was successfully created"
    click_on "Back"
  end

  test "should update Import record" do
    visit import_record_url(@import_record)
    click_on "Edit this import record", match: :first

    fill_in "Csv", with: @import_record.csv
    fill_in "Success", with: @import_record.success
    fill_in "User", with: @import_record.user_id
    click_on "Update Import record"

    assert_text "Import record was successfully updated"
    click_on "Back"
  end

  test "should destroy Import record" do
    visit import_record_url(@import_record)
    click_on "Destroy this import record", match: :first

    assert_text "Import record was successfully destroyed"
  end
end
