class FileRecordsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_file_record, only: [ :show, :edit, :destroy, :share ]

  def index
    @file_records = current_user.file_records.order(created_at: :desc)
  end

  def new
    @file_record = current_user.file_records.new
  end

  def create
    @file_record = current_user.file_records.new(file_record_params)

    if @file_record.save
      redirect_to file_records_path, notice: "File was successfully uploaded."
    else
      render :new
    end
  end

  def destroy
    @file_record.destroy
    redirect_to file_records_url, notice: "File was successfully deleted."
  end

  def share
    begin
      @file_record = current_user.file_records.find(params[:id])
      @shared_link = @file_record.shared_link || @file_record.create_shared_link
      @shared_link.update!(slug: SecureRandom.urlsafe_base64(8))
      redirect_to @file_record, notice: "Shareable link created successfully"
    rescue => e
      redirect_to @file_record, alert: "Failed to create share link: #{e.message}"
    end
  end

  private

  def set_file_record
    @file_record = current_user.file_records.find(params[:id])
  end

  def file_record_params
    params.require(:file_record).permit(:title, :description, :file)
  end
end
