class DashesController < ApplicationController
  def get
    d = Dash.find(params[:id]) || Dash.new(params[:id])
    render :json => d
  end
end
