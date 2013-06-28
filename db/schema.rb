# -*- encoding : utf-8 -*-
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 0) do

  create_table "points_account", :primary_key => "PUBLISHER_ID", :force => true do |t|
    t.integer  "CURRENT_POINTS",                  :default => 0, :null => false
    t.integer  "TOTAL_CHARGE",                    :default => 0, :null => false
    t.integer  "TOTAL_USED",                      :default => 0, :null => false
    t.integer  "AVAILABLE_POINTS",                :default => 0, :null => false
    t.integer  "ALIPAY_AMOUNT",                   :default => 0, :null => false
    t.integer  "GARBAGE_AMOUNT",                  :default => 0, :null => false
    t.string   "PUBLISHER_NAME",   :limit => 100
    t.datetime "INSERT_TIME"
  end

  create_table "points_account_record", :primary_key => "ID", :force => true do |t|
    t.integer  "PUBLISHER_ID",                                   :null => false
    t.integer  "ACTIVITY_ID",                                    :null => false
    t.integer  "POINTS",                      :default => 0,     :null => false
    t.string   "DESCRIPTION",  :limit => 100, :default => ""
    t.datetime "TIME",                                           :null => false
    t.boolean  "TYPE",                        :default => false, :null => false
    t.string   "CARD_NO",      :limit => 128
  end

  add_index "points_account_record", ["PUBLISHER_ID"], :name => "PUBLISHER_ID_IDX"

  create_table "points_activity", :primary_key => "ID", :force => true do |t|
    t.integer   "PUBLISHER_ID",                                      :null => false
    t.binary    "UUID",           :limit => 16,                      :null => false
    t.string    "DOMAIN",         :limit => 100,  :default => ""
    t.string    "URL",            :limit => 200
    t.string    "PIC",            :limit => 200
    t.string    "NAME",           :limit => 1000
    t.string    "DESCRIPTION",    :limit => 3000
    t.date      "START_DATE",                                        :null => false
    t.date      "END_DATE",                                          :null => false
    t.integer   "TOTAL_POINTS",                   :default => 0,     :null => false
    t.integer   "USED_POINTS",                    :default => 0,     :null => false
    t.boolean   "STATUS",                         :default => true,  :null => false
    t.boolean   "ACTIVITY_CATE",                  :default => true,  :null => false
    t.boolean   "is_topic",                       :default => false, :null => false
    t.boolean   "back_points",                    :default => true,  :null => false
    t.boolean   "RE_CLAIM",                       :default => false, :null => false
    t.string    "PUBLISHER_NAME", :limit => 1000
    t.string    "PUBLISHER_SITE", :limit => 100
    t.string    "ACTIVITY_INFO",  :limit => 100
    t.integer   "TASK_ID",                        :default => 0,     :null => false
    t.integer   "TOTAL_USER",                     :default => 0,     :null => false
    t.integer   "POINTS_USER",                    :default => 0,     :null => false
    t.datetime  "UPDATE_TIME"
    t.timestamp "INSERT_TIME"
  end

  add_index "points_activity", ["PUBLISHER_ID"], :name => "ACTIVITY_PUBLISHER_ID"
  add_index "points_activity", ["UUID"], :name => "ACTIVITY_UUID"

  create_table "points_activity_daily", :primary_key => "ID", :force => true do |t|
    t.integer "ACTIVITY_ID",                                      :null => false
    t.date    "DATE",                                             :null => false
    t.integer "PLATFORM_ID",                                      :null => false
    t.binary  "UUID",                :limit => 16,                :null => false
    t.integer "SHARE_COUNT",         :limit => 8,  :default => 0, :null => false
    t.integer "CLICKBACK_COUNT",     :limit => 8,  :default => 0, :null => false
    t.integer "CLICK_REFERER_COUNT", :limit => 8,  :default => 0, :null => false
  end

  add_index "points_activity_daily", ["ACTIVITY_ID", "DATE", "PLATFORM_ID"], :name => "ACTIVITY_ID_DATE_PLATFORM", :unique => true

  create_table "points_activity_limit", :primary_key => "ID", :force => true do |t|
    t.integer "ACTIVITY_ID",                                  :null => false
    t.boolean "LIMIT_KEY",                  :default => true, :null => false
    t.string  "LIMIT_VALUE", :limit => 100
  end

  add_index "points_activity_limit", ["ACTIVITY_ID", "LIMIT_KEY"], :name => "ACTIVITY_ID", :unique => true

  create_table "points_activity_limit_rule", :primary_key => "ACTIVITY_ID", :force => true do |t|
    t.string  "DOMAIN",                   :limit => 100, :default => ""
    t.integer "SHARE_LIMIT_NO",                          :default => 0,  :null => false
    t.integer "CLICKBACK_LIMIT_NO",                      :default => 0,  :null => false
    t.integer "ANTICHEAT_SHARE_LIMIT_NO",                :default => 1,  :null => false
    t.integer "ANTICHEAT_BACK_LIMIT_NO",                 :default => 1,  :null => false
  end

  create_table "points_activity_stat", :primary_key => "ACTIVITY_ID", :force => true do |t|
    t.integer "ACCEPT", :null => false
    t.integer "REJECT", :null => false
    t.integer "FINISH", :null => false
  end

  create_table "points_activity_stat_no", :primary_key => "ID", :force => true do |t|
    t.integer "ACTIVITY_ID",               :null => false
    t.string  "RECORD_ID",   :limit => 50, :null => false
    t.boolean "STAT_TYPE",                 :null => false
    t.date    "CURR_DATE",                 :null => false
    t.integer "TOTAL_NO",                  :null => false
  end

  add_index "points_activity_stat_no", ["ACTIVITY_ID", "RECORD_ID", "STAT_TYPE", "CURR_DATE"], :name => "ACTIVITY_ID", :unique => true

  create_table "points_activity_task_reward", :id => false, :force => true do |t|
    t.integer  "user_id", :default => 0, :null => false
    t.text     "name"
    t.integer  "POINTS",  :default => 0, :null => false
    t.datetime "s_time",                 :null => false
  end

  create_table "points_activity_top_stat", :primary_key => "ACTIVITY_ID", :force => true do |t|
    t.integer "VIEW_COUNT", :default => 0, :null => false
  end

  create_table "points_activity_user_track", :primary_key => "ID", :force => true do |t|
    t.integer  "ACTIVITY_ID",                                :null => false
    t.integer  "USER_ID",                     :default => 0
    t.string   "URL",         :limit => 1000
    t.integer  "USER_IP",                     :default => 0
    t.string   "V_ID",        :limit => 50
    t.integer  "BURL_ID",     :limit => 8,    :default => 0
    t.boolean  "POINTS_TYPE"
    t.datetime "INSERT_TIME",                                :null => false
    t.integer  "PLATFORM_ID",                 :default => 0
    t.integer  "SHARE_ID",                    :default => 0
    t.string   "REFERER",     :limit => 200
  end

  add_index "points_activity_user_track", ["ACTIVITY_ID", "USER_ID"], :name => "ACTIVITY_ID"

  create_table "points_ad", :primary_key => "ID", :force => true do |t|
    t.integer  "BRANCH_ID",                    :default => 0,     :null => false
    t.integer  "BR_ADID",                      :default => 0,     :null => false
    t.integer  "PARENT_ID",                    :default => 0,     :null => false
    t.string   "LINK",         :limit => 500,                     :null => false
    t.string   "IMAGE_URL",    :limit => 500,                     :null => false
    t.string   "BACK_IMAGE",   :limit => 200
    t.string   "NICK_IMAGE",   :limit => 200
    t.string   "NAME",         :limit => 50,                      :null => false
    t.string   "NICK_NAME",    :limit => 50
    t.boolean  "AD_CATEGORY",                  :default => false, :null => false
    t.boolean  "TEMPLATE",                     :default => true,  :null => false
    t.string   "DESCP",        :limit => 5000,                    :null => false
    t.boolean  "BILL_TYPE",                                       :null => false
    t.boolean  "DEDUCT_TYPE",                  :default => false, :null => false
    t.date     "START_DATE",                                      :null => false
    t.date     "END_DATE",                                        :null => false
    t.date     "AUDIT_DATE"
    t.integer  "REVENUE",                      :default => 0,     :null => false
    t.integer  "POINTS",                       :default => 0,     :null => false
    t.integer  "TOTAL_POINTS",                 :default => 0,     :null => false
    t.integer  "SHARING_RATE",                 :default => 0,     :null => false
    t.boolean  "IP_ONCE",                                         :null => false
    t.integer  "DISPLAY",      :limit => 1,    :default => 0,     :null => false
    t.integer  "USER_TIME",                    :default => 0,     :null => false
    t.boolean  "CHECK_BYDAY",                  :default => false, :null => false
    t.string   "USER_AREA",    :limit => 200
    t.string   "AD_SCRIPT",    :limit => 1000
    t.integer  "MAX_USER",                     :default => 0,     :null => false
    t.integer  "JOIN_USER",                    :default => 0,     :null => false
    t.string   "REMARK",       :limit => 1000
    t.integer  "ACTIVITY_ID",                  :default => 0,     :null => false
    t.integer  "AWARD_LIMIT",                  :default => 0,     :null => false
    t.datetime "INSERT_TIME",                                     :null => false
  end

  create_table "points_ad_bck", :id => false, :force => true do |t|
    t.integer  "ID",                           :default => 0,     :null => false
    t.integer  "BRANCH_ID",                    :default => 0,     :null => false
    t.integer  "BR_ADID",                      :default => 0,     :null => false
    t.integer  "PARENT_ID",                    :default => 0,     :null => false
    t.string   "LINK",         :limit => 500,                     :null => false
    t.string   "IMAGE_URL",    :limit => 500,                     :null => false
    t.string   "BACK_IMAGE",   :limit => 200
    t.string   "NICK_IMAGE",   :limit => 200
    t.string   "NAME",         :limit => 50,                      :null => false
    t.string   "NICK_NAME",    :limit => 50
    t.boolean  "AD_CATEGORY",                  :default => false, :null => false
    t.boolean  "TEMPLATE",                     :default => true,  :null => false
    t.string   "DESCP",        :limit => 5000,                    :null => false
    t.boolean  "BILL_TYPE",                                       :null => false
    t.boolean  "DEDUCT_TYPE",                  :default => false, :null => false
    t.date     "START_DATE",                                      :null => false
    t.date     "END_DATE",                                        :null => false
    t.integer  "REVENUE",                      :default => 0,     :null => false
    t.integer  "POINTS",                       :default => 0,     :null => false
    t.integer  "TOTAL_POINTS",                 :default => 0,     :null => false
    t.integer  "SHARING_RATE",                 :default => 0,     :null => false
    t.boolean  "IP_ONCE",                                         :null => false
    t.integer  "DISPLAY",      :limit => 1,    :default => 0,     :null => false
    t.integer  "USER_TIME",                    :default => 0,     :null => false
    t.boolean  "CHECK_BYDAY",                  :default => false, :null => false
    t.string   "USER_AREA",    :limit => 200
    t.string   "AD_SCRIPT",    :limit => 1000
    t.integer  "MAX_USER",                     :default => 0,     :null => false
    t.integer  "JOIN_USER",                    :default => 0,     :null => false
    t.string   "REMARK",       :limit => 1000
    t.integer  "ACTIVITY_ID",                  :default => 0,     :null => false
    t.integer  "AWARD_LIMIT",                  :default => 0,     :null => false
    t.datetime "INSERT_TIME",                                     :null => false
  end

  create_table "points_ad_feedback", :primary_key => "ID", :force => true do |t|
    t.integer  "BRANCH_ID",                   :default => 0,     :null => false
    t.integer  "AD_ID",                       :default => 0,     :null => false
    t.datetime "FEED_TIME",                                      :null => false
    t.integer  "JOIN_USERID",                 :default => 0,     :null => false
    t.string   "OTHER_USERID", :limit => 100
    t.integer  "COMM",                        :default => 0,     :null => false
    t.integer  "TOTAL_PRICE",                 :default => 0,     :null => false
    t.string   "OUT_BIZNO",    :limit => 50
    t.boolean  "PAY_MODE",                    :default => true,  :null => false
    t.boolean  "ORDER_STATUS",                :default => true,  :null => false
    t.boolean  "PAY_STATUS",                  :default => true,  :null => false
    t.boolean  "CONFIRMD",                    :default => false, :null => false
    t.string   "REMARK",       :limit => 250
    t.datetime "INSERT_TIME",                                    :null => false
  end

  create_table "points_ad_user_record", :id => false, :force => true do |t|
    t.integer  "ID",                                         :null => false
    t.integer  "BRANCH_ID",                   :default => 0, :null => false
    t.integer  "AD_ID",                       :default => 0, :null => false
    t.integer  "USER_ID",                     :default => 0, :null => false
    t.integer  "USER_IP",                     :default => 0, :null => false
    t.integer  "POINTS",                      :default => 0, :null => false
    t.boolean  "TRANS_STATUS",                               :null => false
    t.string   "OUT_BIZNO",    :limit => 50
    t.string   "OUT_USER_ID",  :limit => 50
    t.boolean  "DEDUCT_TYPE",                                :null => false
    t.string   "REASON",       :limit => 100
    t.datetime "INSERT_TIME",                                :null => false
  end

  add_index "points_ad_user_record", ["AD_ID", "USER_IP"], :name => "AD_USER_IP"
  add_index "points_ad_user_record", ["BRANCH_ID", "OUT_BIZNO"], :name => "BRANCH_OUT_BIZNO"

  create_table "points_alipay_record", :primary_key => "ID", :force => true do |t|
    t.integer  "RECORD_ID",                                   :null => false
    t.integer  "PUBLISHER_ID",                :default => 0
    t.integer  "POINTS",                                      :null => false
    t.integer  "POUNDAGE",                                    :null => false
    t.integer  "TOTAL_FEE",                   :default => 0,  :null => false
    t.string   "TRADE_NO",     :limit => 100, :default => ""
    t.integer  "ALI_TRADE_NO", :limit => 8,   :default => 0,  :null => false
    t.integer  "TRADE_STATUS",                :default => 0,  :null => false
    t.datetime "CREATE_TIME",                                 :null => false
    t.datetime "PAYMENT_TIME",                                :null => false
  end

  create_table "points_anticheat_back_stat", :primary_key => "ID", :force => true do |t|
    t.integer "ACTIVITY_ID",                              :null => false
    t.string  "V_ID",        :limit => 20,                :null => false
    t.binary  "URL_HASH",    :limit => 16,                :null => false
    t.date    "CREATE_DAY",                               :null => false
    t.integer "STAT_NO",                   :default => 0, :null => false
  end

  add_index "points_anticheat_back_stat", ["ACTIVITY_ID", "V_ID", "URL_HASH", "CREATE_DAY"], :name => "ACTIVITY_ID", :unique => true

  create_table "points_anticheat_share_stat", :primary_key => "ID", :force => true do |t|
    t.integer "ACTIVITY_ID",                              :null => false
    t.integer "USER_ID",                   :default => 0, :null => false
    t.date    "CREATE_DAY",                               :null => false
    t.binary  "URL_HASH",    :limit => 16,                :null => false
    t.integer "PLATFORM_ID",                              :null => false
    t.integer "STAT_NO",                   :default => 0, :null => false
  end

  add_index "points_anticheat_share_stat", ["ACTIVITY_ID", "USER_ID", "CREATE_DAY", "URL_HASH", "PLATFORM_ID"], :name => "ACTIVITY_ID", :unique => true

  create_table "points_api_branch", :primary_key => "ID", :force => true do |t|
    t.integer "USER_ID",                      :default => 0, :null => false
    t.binary  "UUID",           :limit => 16,                :null => false
    t.integer "PARENT_ID",                    :default => 0, :null => false
    t.string  "BRANCH_NAME",    :limit => 50
    t.integer "CURRENT_POINTS",               :default => 0, :null => false
    t.integer "USED_POINTS",                  :default => 0, :null => false
    t.integer "TASK_ID",                      :default => 0, :null => false
    t.integer "DEFAULT_ADID",                 :default => 0, :null => false
    t.date    "EXPIRED_TIME"
    t.integer "VALID_DAY",                    :default => 0, :null => false
    t.integer "FORECAST_NUM",                 :default => 0, :null => false
    t.date    "INSERT_TIME"
  end

  add_index "points_api_branch", ["UUID", "USER_ID"], :name => "UUID", :unique => true

  create_table "points_api_record", :primary_key => "ID", :force => true do |t|
    t.integer  "USER_ID",                    :default => 0,    :null => false
    t.string   "QUERY_STR",   :limit => 200
    t.integer  "IP",          :limit => 8,   :default => 0,    :null => false
    t.boolean  "API_CATE",                   :default => true, :null => false
    t.string   "IS_SUCCESS",  :limit => 1,   :default => "F",  :null => false
    t.string   "RESULT_STR",  :limit => 200, :default => ""
    t.datetime "INSERT_TIME",                                  :null => false
  end

  create_table "points_event_record", :primary_key => "ID", :force => true do |t|
    t.integer   "TASK_ID",                     :default => 0, :null => false
    t.integer   "USER_ID",                     :default => 0, :null => false
    t.timestamp "APPLY_TIME"
    t.timestamp "EXPIRED_TIME"
    t.integer   "POINTS",                      :default => 0, :null => false
    t.string    "REMARK",       :limit => 200
    t.timestamp "INSERT_TIME"
  end

  add_index "points_event_record", ["TASK_ID", "USER_ID"], :name => "TASK_ID"

  create_table "points_forecast_message", :primary_key => "ID", :force => true do |t|
    t.string    "TITLE",           :limit => 200
    t.string    "CONTENT_HEAD",    :limit => 200
    t.boolean   "FORECAST_MODULE",                :default => true, :null => false
    t.boolean   "SEND_TYPE",                      :default => true, :null => false
    t.string    "RELATE_USER",     :limit => 200
    t.boolean   "STATUS",                         :default => true, :null => false
    t.timestamp "INSERT_TIME",                                      :null => false
  end

  create_table "points_merchant", :primary_key => "ID", :force => true do |t|
    t.string   "NAME",      :limit => 100, :null => false
    t.string   "HOME_URL",  :limit => 100
    t.datetime "JOIN_TIME",                :null => false
    t.string   "USER_MAIL", :limit => 100
    t.integer  "USER_ID"
  end

  create_table "points_operate_his", :primary_key => "ID", :force => true do |t|
    t.boolean  "MODULE_NAME",  :null => false
    t.boolean  "OPERATE_TYPE", :null => false
    t.integer  "TABLE_ID",     :null => false
    t.integer  "USER_ID",      :null => false
    t.datetime "INSERT_TIME",  :null => false
  end

  create_table "points_order", :primary_key => "ID", :force => true do |t|
    t.string   "ORDER_NO",        :limit => 30
    t.integer  "PRODUCT_ID",                                    :null => false
    t.integer  "USER_ID",                                       :null => false
    t.string   "CONTACT_NAME",    :limit => 100
    t.string   "CONTACT_ADDRESS", :limit => 200
    t.string   "CONTACT_NO",      :limit => 50
    t.string   "ZIP_CODE",        :limit => 50
    t.integer  "ORDER_POINTS",                                  :null => false
    t.integer  "PROD_NUM",                                      :null => false
    t.datetime "ORDER_TIME",                                    :null => false
    t.boolean  "ORDER_STATUS",                                  :null => false
    t.string   "OTHER_INFO",      :limit => 400
    t.string   "OUT_TRADNO",      :limit => 200
    t.string   "REMARK",          :limit => 200
    t.integer  "USER_ACCOUNT_ID",                :default => 0
  end

  add_index "points_order", ["ORDER_NO"], :name => "ORDER_NO_IDX", :unique => true
  add_index "points_order", ["PRODUCT_ID", "ORDER_TIME"], :name => "PRODUCT_ID_IDX"
  add_index "points_order", ["USER_ID"], :name => "USER_ID_IDX"

  create_table "points_order_lottery", :primary_key => "ID", :force => true do |t|
    t.integer "ORDER_ID"
    t.integer "PRODUCT_ID"
    t.string  "LOTTERY_NO", :limit => 50, :null => false
  end

  add_index "points_order_lottery", ["PRODUCT_ID", "LOTTERY_NO"], :name => "PRODUCT_LOTTERY_NO", :unique => true

  create_table "points_point_rule", :primary_key => "ID", :force => true do |t|
    t.integer "ACTIVITY_ID",                                     :null => false
    t.boolean "TYPE",                         :default => false, :null => false
    t.integer "NUM",                          :default => 1
    t.integer "POINTS",                       :default => 0,     :null => false
    t.integer "PRODUCT_ID",                   :default => 0,     :null => false
    t.boolean "PRODUCT_NUM",                  :default => false, :null => false
    t.string  "RELATED_LINK", :limit => 100
    t.string  "UID",          :limit => 50
    t.integer "PLATFORM_ID",                  :default => 0,     :null => false
    t.string  "REMARK",       :limit => 2000
    t.string  "TWEET",        :limit => 200
  end

  add_index "points_point_rule", ["ACTIVITY_ID"], :name => "ACTIVITY_ID"

  create_table "points_product", :primary_key => "ID", :force => true do |t|
    t.string   "NAME",           :limit => 1000
    t.string   "DESCP",          :limit => 3000
    t.string   "DESC_URL",       :limit => 300
    t.integer  "PROD_CATE",                                        :null => false
    t.string   "PIC",            :limit => 200
    t.string   "BRAND",          :limit => 1000
    t.string   "TAGS",           :limit => 1000
    t.integer  "PRICE_M",                                          :null => false
    t.integer  "INITIAL_POINTS",                                   :null => false
    t.integer  "CURRENT_POINTS",                                   :null => false
    t.integer  "CURR_NUM",                       :default => 1
    t.integer  "MERCHANT_ID",                                      :null => false
    t.integer  "STORE_NUM",                      :default => 0,    :null => false
    t.integer  "SELL_NUM",                       :default => 0,    :null => false
    t.datetime "INSERT_TIME",                                      :null => false
    t.datetime "EXPIRE_DATE"
    t.boolean  "STATUS",                                           :null => false
    t.boolean  "SHOW_ADDRESS",                   :default => true, :null => false
    t.integer  "AUDIT_BY"
    t.datetime "AUDIT_TIME"
    t.datetime "UPDATE_TIME"
  end

  add_index "points_product", ["PROD_CATE"], :name => "PROD_CATE_IDX"

  create_table "points_product_category", :primary_key => "ID", :force => true do |t|
    t.string   "CODE",        :limit => 30
    t.integer  "PARENT_ID",                  :null => false
    t.string   "NAME",        :limit => 100
    t.string   "NAME_EN",     :limit => 100, :null => false
    t.boolean  "STATUS",                     :null => false
    t.datetime "INSERT_TIME",                :null => false
  end

  add_index "points_product_category", ["PARENT_ID"], :name => "PARENT_ID_IDX"

  create_table "points_product_day_stat", :primary_key => "ID", :force => true do |t|
    t.integer  "PRODUCT_ID",   :default => 0, :null => false
    t.date     "STAT_DAY",                    :null => false
    t.integer  "TOTAL_NUM",    :default => 0, :null => false
    t.integer  "TOTAL_USER",   :default => 0, :null => false
    t.integer  "TOTAL_POINTS", :default => 0, :null => false
    t.integer  "CURR_STORE",   :default => 0, :null => false
    t.datetime "INSERT_TIME",                 :null => false
  end

  create_table "points_product_top_stat", :primary_key => "PRODUCT_ID", :force => true do |t|
    t.integer "VIEW_COUNT",     :default => 0, :null => false
    t.integer "EXCHANGE_COUNT", :default => 0, :null => false
  end

  create_table "points_product_try", :primary_key => "ID", :force => true do |t|
    t.integer  "PRODUCT_ID",                                        :null => false
    t.date     "START_DAY",                                         :null => false
    t.date     "END_DAY",                                           :null => false
    t.boolean  "POST",                           :default => false, :null => false
    t.string   "TRY_AREA",       :limit => 100
    t.string   "TRY_REPORT",     :limit => 200
    t.integer  "FREE_NUM",                       :default => 0,     :null => false
    t.integer  "FREE_APPLY_NUM",                 :default => 0,     :null => false
    t.string   "FREE_RULE",      :limit => 500
    t.integer  "FEE_NUM",                        :default => 0,     :null => false
    t.integer  "FEE_APPLY_NUM",                  :default => 0,     :null => false
    t.integer  "FEE_MONEY",                      :default => 0,     :null => false
    t.string   "FEE_RULE",       :limit => 500
    t.string   "DESCP",          :limit => 2000
    t.datetime "INSERT_TIME"
  end

  add_index "points_product_try", ["PRODUCT_ID"], :name => "PRODUCT_ID"

  create_table "points_recharge_card", :primary_key => "ID", :force => true do |t|
    t.string   "CARD_NO",      :limit => 128,                   :null => false
    t.string   "CARD_PWD",     :limit => 32,                    :null => false
    t.datetime "BEGIN_TIME",                                    :null => false
    t.datetime "END_TIME",                                      :null => false
    t.datetime "CREATE_TIME",                                   :null => false
    t.datetime "UPDATE_TIME",                                   :null => false
    t.boolean  "CARD_STATUS",                 :default => true, :null => false
    t.integer  "CARD_LIMIT",                                    :null => false
    t.integer  "CREATOR_ID",                                    :null => false
    t.string   "CREATOR_NAME", :limit => 256,                   :null => false
  end

  create_table "points_recommend", :primary_key => "ID", :force => true do |t|
    t.boolean "RECOMMEND_TYPE",                               :null => false
    t.string  "RECOMMEND_DESC",  :limit => 64,                :null => false
    t.integer "RECOMMEND_COUNT",               :default => 0, :null => false
  end

  create_table "points_recommend_activity", :id => false, :force => true do |t|
    t.integer  "RECOMMEND_ID", :null => false
    t.integer  "ACTIVITY_ID",  :null => false
    t.datetime "UPDATE_TIME",  :null => false
  end

  create_table "points_recommend_product", :id => false, :force => true do |t|
    t.integer  "RECOMMEND_ID", :null => false
    t.integer  "PRODUCT_ID",   :null => false
    t.datetime "UPDATE_TIME",  :null => false
  end

  create_table "points_stat_day", :primary_key => "ID", :force => true do |t|
    t.date     "STAT_DAY",                       :null => false
    t.integer  "TOTAL_USER",      :default => 0, :null => false
    t.integer  "NEW_USER",        :default => 0, :null => false
    t.integer  "CURR_GRANT",      :default => 0, :null => false
    t.integer  "CURR_GRANT_TA",   :default => 0
    t.integer  "CURR_COST",       :default => 0, :null => false
    t.integer  "CURR_USER",       :default => 0, :null => false
    t.integer  "CURR_USER_TASK",  :default => 0
    t.integer  "CURR_ACTIVITYS",  :default => 0, :null => false
    t.integer  "OTHER_POINTS",    :default => 0
    t.integer  "OTHER_USER",      :default => 0, :null => false
    t.integer  "CURR_ALIFEE",     :default => 0, :null => false
    t.integer  "CURR_TOTAL_USER", :default => 0
    t.datetime "INSERT_TIME",                    :null => false
  end

  create_table "points_system_fault", :primary_key => "ID", :force => true do |t|
    t.boolean "MODULE",                     :default => true, :null => false
    t.integer "RECORD_ID",                  :default => 0,    :null => false
    t.date    "START_DATE",                                   :null => false
    t.date    "END_DATE",                                     :null => false
    t.string  "MESSAGE",     :limit => 200,                   :null => false
    t.date    "INSERT_TIME",                                  :null => false
  end

  create_table "points_task", :primary_key => "ID", :force => true do |t|
    t.string   "NAME",          :limit => 50,                    :null => false
    t.string   "DESCP",         :limit => 1000
    t.string   "LINK_URL",      :limit => 300
    t.string   "PIC",           :limit => 100
    t.boolean  "AWARD_TYPE",                                     :null => false
    t.boolean  "TASK_CATEGORY",                                  :null => false
    t.integer  "AWARD_NO",                      :default => 0,   :null => false
    t.datetime "EXPIRED_DATE"
    t.string   "ROLES",         :limit => 50,                    :null => false
    t.boolean  "STATUS",                                         :null => false
    t.integer  "CLEAR_DAY",                     :default => 0,   :null => false
    t.integer  "TOTAL_NO",                      :default => 0,   :null => false
    t.integer  "FINISH_NO",                     :default => 0,   :null => false
    t.string   "ACCOUNT_UID",   :limit => 50,   :default => "0"
  end

  create_table "points_task_day_stat", :primary_key => "ID", :force => true do |t|
    t.integer "TASK_ID",                  :null => false
    t.date    "CURR_DAY",                 :null => false
    t.integer "TOTAL_NO",  :default => 0, :null => false
    t.integer "FINISH_NO", :default => 0, :null => false
  end

  add_index "points_task_day_stat", ["TASK_ID", "CURR_DAY"], :name => "TASK_ID", :unique => true

  create_table "points_task_lottery", :primary_key => "ID", :force => true do |t|
    t.integer "TASK_ID",    :default => 0, :null => false
    t.integer "PRODUCT_ID", :default => 0, :null => false
    t.integer "RATE",       :default => 0, :null => false
    t.date    "START_DATE",                :null => false
    t.date    "END_DATE",                  :null => false
  end

  create_table "points_task_user", :primary_key => "ID", :force => true do |t|
    t.integer  "TASK_ID",    :null => false
    t.integer  "USER_ID",    :null => false
    t.boolean  "USER_OPER",  :null => false
    t.boolean  "AWARD_TYPE", :null => false
    t.integer  "AWARD_NO",   :null => false
    t.datetime "OPER_TIME",  :null => false
  end

  add_index "points_task_user", ["TASK_ID"], :name => "TASK_ID"
  add_index "points_task_user", ["USER_ID", "TASK_ID", "USER_OPER"], :name => "USER_ID"
  add_index "points_task_user", ["USER_OPER"], :name => "USER_OPER"

  create_table "points_trans_record", :primary_key => "ID", :force => true do |t|
    t.integer  "BRANCH_ID",                       :default => 0
    t.integer  "AD_ID",                           :default => 0
    t.boolean  "API_CATE",                        :default => false, :null => false
    t.integer  "USER_ID",                         :default => 0,     :null => false
    t.integer  "POINTS",                          :default => 0,     :null => false
    t.string   "OUT_BIZNO",         :limit => 50,                    :null => false
    t.integer  "ACTIVITY_ID",                     :default => 0,     :null => false
    t.boolean  "DEDUCT_TYPE",                     :default => true,  :null => false
    t.boolean  "SETTLEMENT_STATUS",               :default => false, :null => false
    t.datetime "SETTLE_DATE"
    t.integer  "SETTLE_BY",                       :default => 0
    t.datetime "INSERT_TIME",                                        :null => false
  end

  add_index "points_trans_record", ["OUT_BIZNO"], :name => "UUID"

  create_table "points_try_order", :primary_key => "ID", :force => true do |t|
    t.integer   "TRY_ID",                         :default => 0,     :null => false
    t.integer   "PROD_ID",                        :default => 0,     :null => false
    t.integer   "USER_ID",                        :default => 0,     :null => false
    t.string    "ORDER_NO",        :limit => 50
    t.boolean   "TRY_TYPE",                       :default => true,  :null => false
    t.timestamp "APPLY_TIME"
    t.timestamp "EXPIRED_TIME"
    t.string    "CONTACT_NAME",    :limit => 100
    t.string    "CONTACT_ADDRESS", :limit => 200
    t.string    "CONTACT_NO",      :limit => 50
    t.string    "ZIP_CODE",        :limit => 50
    t.boolean   "TRY_STATUS",                     :default => false, :null => false
    t.integer   "POINTS",                         :default => 0,     :null => false
    t.integer   "FEE",                            :default => 0,     :null => false
    t.string    "ALI_TRADE_NO",    :limit => 50
    t.datetime  "PAYMENT_TIME"
    t.string    "REMARK",          :limit => 100
  end

  add_index "points_try_order", ["ORDER_NO"], :name => "ORDER_NO", :unique => true

  create_table "points_user", :primary_key => "USER_ID", :force => true do |t|
    t.string    "USER_NAME",          :limit => 50
    t.integer   "POINTS",                            :default => 0,     :null => false
    t.integer   "USED_POINTS",                       :default => 0,     :null => false
    t.integer   "FROZEN_POINTS",                     :default => 0,     :null => false
    t.boolean   "STATUS",                            :default => false, :null => false
    t.boolean   "FROZEN_REASON",                     :default => false, :null => false
    t.timestamp "FROZEN_TIME"
    t.string    "CONTACT_NAME",       :limit => 100
    t.string    "CONTACT_ADDRESS",    :limit => 200
    t.string    "CONTACT_NO",         :limit => 100
    t.string    "ZIP_CODE",           :limit => 50
    t.string    "STATE",              :limit => 50
    t.string    "CITY",               :limit => 50
    t.string    "AVATAR",             :limit => 200
    t.boolean   "EMAILED",                           :default => false, :null => false
    t.string    "VERIFY_EMAIL",       :limit => 100
    t.date      "VERIFY_TIME"
    t.binary    "INVITE_CODE",        :limit => 16
    t.binary    "SOURCE_INVITE_CODE", :limit => 16
    t.boolean   "INVITE_REWARDED",                   :default => false
    t.datetime  "INSERT_TIME"
  end

  add_index "points_user", ["INVITE_CODE"], :name => "INVITE_CODE_INDEX"

  create_table "points_user_account", :primary_key => "ID", :force => true do |t|
    t.integer  "USER_ID",                         :null => false
    t.integer  "POINTS_CATE",                     :null => false
    t.string   "ACCOUNT_NAME",     :limit => 200
    t.string   "ALIPAY_USER_ID",   :limit => 64,  :null => false
    t.string   "ALIPAY_REAL_NAME", :limit => 200, :null => false
    t.datetime "UPDATE_TIME"
  end

  add_index "points_user_account", ["USER_ID", "POINTS_CATE", "ALIPAY_USER_ID"], :name => "USER_POINTS_ACCOUNT", :unique => true

  create_table "points_user_message_records", :primary_key => "ID", :force => true do |t|
    t.integer  "CREATE_USER_ID",                                        :null => false
    t.string   "CREATE_USER_NAME",    :limit => 100,                    :null => false
    t.string   "MESSAGE_CONTENT",     :limit => 1000,                   :null => false
    t.boolean  "MESSAGE_RECORD_TYPE",                 :default => true, :null => false
    t.datetime "CREATE_TIME",                                           :null => false
  end

  add_index "points_user_message_records", ["CREATE_USER_ID", "CREATE_TIME"], :name => "USER_MESSAGES"

  create_table "points_user_messages", :primary_key => "ID", :force => true do |t|
    t.integer  "USER_ID",                             :null => false
    t.boolean  "MESSAGE_STATE",     :default => true, :null => false
    t.integer  "MESSAGE_RECORD_ID",                   :null => false
    t.datetime "READ_TIME"
  end

  add_index "points_user_messages", ["USER_ID", "MESSAGE_STATE"], :name => "USER_MESSAGES"

  create_table "points_user_point_record", :primary_key => "ID", :force => true do |t|
    t.integer  "USER_ID",                                         :null => false
    t.integer  "ACTIVITY_ID",                                     :null => false
    t.string   "ACTIVITY_NAME", :limit => 400
    t.integer  "POINTS",                       :default => 0,     :null => false
    t.datetime "TIME",                                            :null => false
    t.boolean  "TYPE",                         :default => false
    t.boolean  "STATUS",                       :default => false, :null => false
  end

  add_index "points_user_point_record", ["ACTIVITY_ID"], :name => "ACTIVITY_ID"
  add_index "points_user_point_record", ["TIME"], :name => "TIME"
  add_index "points_user_point_record", ["USER_ID", "ACTIVITY_ID"], :name => "USER_ID_ACTIVITY_POINT"

  create_table "points_user_points_pool", :id => false, :force => true do |t|
    t.integer  "USER_ID",                    :null => false
    t.integer  "ACTIVITY_ID"
    t.integer  "POINT_TYPE"
    t.integer  "COUNT",       :default => 0
    t.datetime "INSERT_TIME"
    t.datetime "UPDATE_TIME"
  end

  add_index "points_user_points_pool", ["ACTIVITY_ID"], :name => "ACTIVITY_ID"
  add_index "points_user_points_pool", ["USER_ID", "ACTIVITY_ID", "POINT_TYPE"], :name => "USER_POINTS_POOL", :unique => true

  create_table "points_user_stat_day", :primary_key => "ID", :force => true do |t|
    t.date     "STAT_DATE",                  :null => false
    t.integer  "USER_ID",     :default => 0, :null => false
    t.integer  "POINTS",      :default => 0, :null => false
    t.boolean  "STAT_TYPE",                  :null => false
    t.datetime "INSERT_TIME",                :null => false
  end

  create_table "points_user_track", :primary_key => "ID", :force => true do |t|
    t.boolean   "TRACK_MODULE",               :default => true, :null => false
    t.integer   "MODULE_ID",                  :default => 0,    :null => false
    t.integer   "USER_ID",                    :default => 0,    :null => false
    t.integer   "IP",                         :default => 0,    :null => false
    t.string    "V_ID",         :limit => 20
    t.timestamp "INSERT_TIME",                                  :null => false
  end

  add_index "points_user_track", ["INSERT_TIME"], :name => "INSERT_TIME"

  create_table "short_url", :primary_key => "ID", :force => true do |t|
    t.binary   "HASH_URL",    :limit => 16
    t.string   "URL",         :limit => 5000
    t.boolean  "TYPE",                        :default => false, :null => false
    t.datetime "CREATE_DATE",                                    :null => false
  end

  add_index "short_url", ["HASH_URL"], :name => "HASH_URL_IDX"

end
