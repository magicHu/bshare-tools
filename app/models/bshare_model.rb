class BshareModel < ActiveRecord::Base
  self.abstract_class = true

  establish_connection "bshare_#{Rails.env}"
end