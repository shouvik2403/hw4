class EntriesController < ApplicationController

  def new
    if @current_user == nil
      flash["notice"] = "You must be logged in to add a new post."
      redirect_to "/login"
    end
  end

  def create
    @entry = Entry.new
    @entry["title"] = params["title"]
    @entry["description"] = params["description"]
    @entry["occurred_on"] = params["occurred_on"]
    @entry["place_id"] = params["place_id"]
    @entry["user_id"] = current_user
    @entry.save
    redirect_to "/places/#{@entry["place_id"]}"
  end

end
