class Ad < BsharePointsModel

  set_table_name "points_ad"

  default_scope :order => 'INSERT_TIME desc'

end