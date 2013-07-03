class AdFeedback < BsharePointsModel

  self.table_name = "points_ad_feedback"

  attr_accessible :ID, :BRANCH_ID, :AD_ID, :FEED_TIME, :JOIN_USERID, :OTHER_USERID, :COMM, :TOTAL_PRICE, :OUT_BIZNO, :PAY_MODE, :ORDER_STATUS, :PAY_STATUS, :CONFIRMD, :REMARK, :INSERT_TIME
  
end