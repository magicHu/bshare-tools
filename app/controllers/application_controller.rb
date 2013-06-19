class ApplicationController < ActionController::Base
  protect_from_forgery

  def production_uuid
    "3ffabe88-9c95-4f7b-a6d4-a6c14c61ba03"
  end

  def production_secret
    "0c79d908-53bf-46ca-ad5a-79e9105d1408"
  end

  def api_base_url
    "http://points.bshare.cn/api/"
  end

  def sign(params, secret)
    @sign_str = params_to_sign_str(params) + secret
    return Digest::MD5.hexdigest(@sign_str)
  end

  def params_to_sign_str(params)
    params_str = ''
    params = params.sort {|x, y| x.to_s <=> y.to_s }
    params.each { |key, value|  params_str << key.to_s << "=" << value.to_s}
    params_str
  end
end
