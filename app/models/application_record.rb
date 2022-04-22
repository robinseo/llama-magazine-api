class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  include Rails.application.routes.url_helpers

  def file_url_of(file)
    file.attached? ? rails_blob_url(file) : nil
  end

  def file_path_of(file)
    file.attached? ? rails_blob_path(file) : nil
  end

end
