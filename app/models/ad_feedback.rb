class AdFeedback < BsharePointsModel

  self.table_name = "points_ad_feedback"

  attr_accessible :ID, :BRANCH_ID, :AD_ID, :FEED_TIME, :JOIN_USERID, :OTHER_USERID, :COMM, :TOTAL_PRICE, :OUT_BIZNO, :PAY_MODE, :ORDER_STATUS, :PAY_STATUS, :CONFIRMD, :REMARK, :INSERT_TIME
  
  def to_ad_record
    record = AdUserRecord.new
    ad = Ad.find(self.AD_ID)
    
    record.BRANCH_ID = self.BRANCH_ID
    record.AD_ID = self.AD_ID
    record.USER_ID = self.JOIN_USERID
    # 用户所的积分数 = 订单总价 * 分成比例
    record.POINTS = self.TOTAL_PRICE * ad.SHARING_RATE / 100
    record.TRANS_STATUS = 1
    record.OUT_BIZNO = self.OUT_BIZNO
    record.OUT_USER_ID = self.OTHER_USERID
    record.DEDUCT_TYPE = ad.DEDUCT_TYPE
    record.INSERT_TIME = Time.now.to_i * 1000

    record
  end
end