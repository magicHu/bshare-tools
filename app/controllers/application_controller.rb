# -*- encoding : utf-8 -*-
class ApplicationController < ActionController::Base
  protect_from_forgery

  @@CACHE = {
    AD: 'P:AD'
  }

  def uuid
    #if Rails.env.production?
      "3ffabe88-9c95-4f7b-a6d4-a6c14c61ba03"
    #else
    #  "0e3a49ed-0522-470c-9df6-041a2ac62259"
    #end
  end

  def secret
    #if Rails.env.production?
      "0c79d908-53bf-46ca-ad5a-79e9105d1408"
    #else
    #  "74e81a05-a738-4c1a-b6e7-eaa0f3c3bf30"
    #end
  end

  def points_base_url
    "http://points.bshare.cn/"
  end

  def refresh_cache_url(cache_key)
    "#{points_base_url}/api/clearCached.json?uuid=#{uuid}&names=#{cache_key}"
  end

  def refresh_cache(cache_key)
    @refresh_cache_url = refresh_cache_url(cache_key)
=begin
    response = HTTParty.get(refresh_cache_url(cache_key))

    if response.code == 200
      result = MultiJson.load(response.body)
      return unless result['isSuccess'] == 'F'
    end
    result['error']
=end
  end

  def sign(params, secret)
    @sign_str = params_to_sign_str(params) + secret
    return Digest::MD5.hexdigest(@sign_str)
  end

  def params_to_sign_str(params)
    params = params.sort {|x, y| x.to_s <=> y.to_s }

    params_str = ''
    params.each { |key, value|  params_str << key.to_s << "=" << value.to_s}
    params_str
  end
end
