module ApplicationHelper
  def display_share_link(file_record)
    if file_record.shared_link
      link_to shared_file_url(file_record.shared_link.slug),
              shared_file_url(file_record.shared_link.slug),
              target: "_blank"
    else
      "Not shared"
    end
  end
end
