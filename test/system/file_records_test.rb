require "application_system_test_case"

class FileRecordsTest < ApplicationSystemTestCase
  setup do
    @file_record = file_records(:one)
  end

  test "visiting the index" do
    visit file_records_url
    assert_selector "h1", text: "File records"
  end

  test "should create file record" do
    visit file_records_url
    click_on "New file record"

    fill_in "Description", with: @file_record.description
    fill_in "Title", with: @file_record.title
    fill_in "User", with: @file_record.user_id
    click_on "Create File record"

    assert_text "File record was successfully created"
    click_on "Back"
  end

  test "should update File record" do
    visit file_record_url(@file_record)
    click_on "Edit this file record", match: :first

    fill_in "Description", with: @file_record.description
    fill_in "Title", with: @file_record.title
    fill_in "User", with: @file_record.user_id
    click_on "Update File record"

    assert_text "File record was successfully updated"
    click_on "Back"
  end

  test "should destroy File record" do
    visit file_record_url(@file_record)
    click_on "Destroy this file record", match: :first

    assert_text "File record was successfully destroyed"
  end
end
