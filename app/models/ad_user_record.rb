class AdUserRecord < BsharePointsModel

  set_table_name　'points_ad_user_record'

  default_scope :order => "INSERT_TIME desc"
end