class TupsController < ApplicationController
  def index
  end

  def create_from_publication
    results = Day.parse(fetch_date).find_dates_from_publication
    @tup = Tup.new(results)
    if @tup.save
      respond_to do |format|
        format.html { redirect_to tup_path(@tup) }
        format.js   { render :key_dates }
      end
    end
  end
    
  def create_from_legal_effect
    @results = Day.parse(fetch_date).find_dates_from_legal_effect
    respond_to do |format|
      format.html { redirect_to tup_path(@tup) }
      format.js   { render :publications }
    end
  end

  def show
  end

  private

  def fetch_date
    params.require(:tup).permit(:publication)[:publication] || params.require(:tup).permit(:legal_effect)[:legal_effect]
  end
end
