class PagesController < ApplicationController
  
  def home
  end
  
  def progress
    @event = Event.find(params[:id])
    msg = $redis.hget @event.import_key, "msg"
    respond_to do |format|
      format.json {render :json => {"msg": msg}}
    end
  end
end