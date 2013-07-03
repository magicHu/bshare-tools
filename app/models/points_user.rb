class PointsUser < BsharePointsModel

  self.table_name  = "points_user"

  attr_accessible :EMAILED, :VERIFY_EMAIL, :VERIFY_TIME
end