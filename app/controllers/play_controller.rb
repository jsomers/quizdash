class PlayController < ApplicationController
  before_filter :require_handle, :except => [:choose_handle, :set_handle]
  def quiz
    @quiz = Quiz.find(params[:id].split("-").first)
    @hash = Digest::MD5.hexdigest(params[:id]).first(10)
  end
  
  def msg
    Juggernaut.publish("/chats", params[:txt])
    render :text => "OK"
  end
  
  def choose_handle
    if session[:handle]
      handles = rget("handles")
      handles.delete(session[:handle])
      rset("handles", handles)
      session[:handle] = nil
    end
  end
  
  def set_handle
    if not_taken(handle = clean(params[:handle]))
      register(handle)
      flash[:notice] = "Now you're playing as <strong>#{handle}</strong>"
      redirect_to_x_or_default "/"
    else
      flash[:alert] = "<strong>#{handle}</strong> is taken&mdash;try another handle"
      redirect_to :action => :choose_handle
    end
  end
  
  private
  
  def not_taken(handle)
    handles = rget("handles")
    handles[handle].nil?
  end
  
  def clean(handle)
    handle.strip.gsub(/[^a-zA-Z0-9\-\_]/, "-").gsub("--", "-")
  end
  
  def register(handle)
    handles = rget("handles")
    handles[handle] = rand(10_000_000_000)
    rset("handles", handles)
    session[:handle] = handle
  end
end