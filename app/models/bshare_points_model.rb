class BsharePointsModel < ActiveRecord::Base
  self.abstract_class = true

  establish_connection "bshare_points_#{Rails.env}"
end