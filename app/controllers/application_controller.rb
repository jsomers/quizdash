class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def require_handle
    unless current_handle
      store_location
      redirect_to :controller => :play, :action => :choose_handle
    end
  end
  
  def current_handle
    session[:handle]
  end
  
  def store_location
    session[:redirect_to] = request.request_uri
  end
  
  def redirect_to_x_or_default(default)
    redirect_to(session[:redirect_to] || default)
    session[:redirect_to] = nil
  end
  
  private
  
  def rget(key)
    JSON.parse($redis.get key)
  end
  
  def rset(key, val)
    $redis.set key, val.to_json
  end
end
