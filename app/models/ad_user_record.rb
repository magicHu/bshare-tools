# -*- encoding : utf-8 -*-
class AdUserRecord < BsharePointsModel

  self.table_name = "points_ad_user_record"

  default_scope :order => "INSERT_TIME desc"

  attr_accessible :ID, :BRANCH_ID, :AD_ID, :USER_ID, :USER_IP, :POINTS, :TRANS_STATUS, :OUT_BIZNO, :OUT_USER_ID, :DEDUCT_TYPE, :REASON, :INSERT_TIME
end
