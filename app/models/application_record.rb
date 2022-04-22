class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  include Rails.application.routes.url_helpers

  def file_url_of(file)
    if Rails.env.development?
      file.attached? ? rails_blob_url(file) : nil
    else
      file.attached? ? file.service_url : nil
    end
  end
end
