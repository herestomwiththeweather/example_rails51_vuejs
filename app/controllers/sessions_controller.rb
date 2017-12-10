require 'uri'
require 'cgi'
require 'net/https'

class SessionsController < ApplicationController
  before_action :setup_oauth_params

  def new
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_url, notice: "Logged out"
  end

  def callback
    if params[:code]
      me = get_authenticated_user(params[:code])
      if me.present?
        user = User.find_or_create_by(url: me)
        session[:user_id] = user.id
        redirect_to root_url
      end
    end

    respond_to do  |format|
      format.html
    end
  end

  def get_authenticated_user(code)
    me = nil
    u = URI.parse('https://indieauth.com')
    http = ::Net::HTTP.new(u.host, u.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    body = "code=#{CGI::escape code}&client_id=#{CGI::escape @client_id}&redirect_uri=#{CGI::escape @redirect_uri}"
    response = http.post('/auth', body, "Content-Type" => "application/x-www-form-urlencoded\r\n", "Accept" => "application/json\r\n")
    parsed_response = JSON.parse(response.body)
    if parsed_response['error'].present?
      Rails.logger.info "XXX get_authenticated_user error #{parsed_response['error']} : #{parsed_response['error_description']}"
    else
      me = parsed_response['me']
    end
    me
  end

  def setup_oauth_params
    @client_id = 'https://austin-indieauth-demo.herokuapp.com/'
    @redirect_uri = 'https://austin-indieauth-demo.herokuapp.com/callback'
  end
end
