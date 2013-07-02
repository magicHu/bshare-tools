# -*- encoding : utf-8 -*-
class Ad < BsharePointsModel

  self.table_name = "points_ad"

  default_scope :order => 'id desc'

  attr_accessible :ID, :BRANCH_ID, :BR_ADID, :PARENT_ID, :LINK, :IMAGE_URL, :BACK_IMAGE, :NICK_IMAGE, :NAME, :NICK_NAME, :AD_CATEGORY, :TEMPLATE, :DESCP, :BILL_TYPE, :DEDUCT_TYPE, :START_DATE, :END_DATE, :AUDIT_DATE, :REVENUE, :POINTS, :TOTAL_POINTS, :SHARING_RATE, :IP_ONCE, :DISPLAY, :USER_TIME, :CHECK_BYDAY, :USER_AREA, :AD_SCRIPT, :MAX_USER, :JOIN_USER, :REMARK, :ACTIVITY_ID, :AWARD_LIMIT, :INSERT_TIME

  @@AD_CATEGORY = { "OTHER" => 0, "GAME" => 1, "QUESTIONNAIRE" => 2 }
  def self.ad_category_enum
    @@AD_CATEGORY
  end

  @@AD_TEMPLATE = { "活动" => 1, "链接" => 2, "游戏" => 3, "CPS" => 4}
  def self.ad_template_enum
    @@AD_TEMPLATE
  end

  @@BILL_TYPE = { "CPC" => 1, "CPA" => 2, "CPS" => 3 }
  def self.bill_type_enum
    @@BILL_TYPE
  end


  @@DEDUCT_TYPE = { "普通账户" => 2, "信用账户" => 1, "活动账户" => 3 }
  def self.duduct_type_enum
    @@DEDUCT_TYPE
  end
end
