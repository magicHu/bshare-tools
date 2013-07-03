class BindUserAccount < BshareModel
  
  self.table_name = "bind_user_account"

  attr_accessible :ID, :USER_ID, :BIND_ACCOUNT_TYPE, :ACCOUNT_UID, :ACCOUNT_NAME, :CREATE_TIME, :UPDATE_TIME

  @@ACCOUNT_TYPE = { "支付宝" => 1 }
  def self.account_type_enum
    @@ACCOUNT_TYPE
  end

end