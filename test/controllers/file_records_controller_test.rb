require "test_helper"

class FileRecordsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @file_record = file_records(:one)
  end

  test "should get index" do
    get file_records_url
    assert_response :success
  end

  test "should get new" do
    get new_file_record_url
    assert_response :success
  end

  test "should create file_record" do
    assert_difference("FileRecord.count") do
      post file_records_url, params: { file_record: { description: @file_record.description, title: @file_record.title, user_id: @file_record.user_id } }
    end

    assert_redirected_to file_record_url(FileRecord.last)
  end

  test "should show file_record" do
    get file_record_url(@file_record)
    assert_response :success
  end

  test "should get edit" do
    get edit_file_record_url(@file_record)
    assert_response :success
  end

  test "should update file_record" do
    patch file_record_url(@file_record), params: { file_record: { description: @file_record.description, title: @file_record.title, user_id: @file_record.user_id } }
    assert_redirected_to file_record_url(@file_record)
  end

  test "should destroy file_record" do
    assert_difference("FileRecord.count", -1) do
      delete file_record_url(@file_record)
    end

    assert_redirected_to file_records_url
  end
end
