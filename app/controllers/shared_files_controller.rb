class SharedFilesController < ApplicationController
  # skip_before_action :authenticate_user!

  def show
    @shared_link = SharedLink.find_by(slug: params[:slug])
    if @shared_link.nil? || @shared_link.expires_at < Time.now
      redirect_to root_path, alert: "Link is invalid or has expired"
    else
      @file_record = @shared_link.file_record
      send_data @file_record.file.download,
                filename: @file_record.file.filename.to_s,
                type: @file_record.file.content_type,
                disposition: "attachment"
    end
  end
end
