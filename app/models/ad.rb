class Ad < BsharePointsModel

  set_table_name "points_ad"

  default_scope :order => 'INSERT_TIME desc'

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