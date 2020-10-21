class TupsController < ApplicationController

  def index
  end
  
  def new
    @tup = Tup.new
  end
  
  def show
    @tup = Tup.find(params[:id])
  end
  
  def create
    
    @results ||= results_from_publication
    @tup = Tup.new(@results)
    raise
    respond_to do |format|
      if @tup.save
        format.html { redirect_to @tup }
        format.js
      else
        format.html { render action: 'new', turbolinks: false }
      end
    end
  end
    
  def display_publications
    @results = results_from_legal_effect
    if (@results[:publications].count < 2)
        @results[:publication] = @results[:publications].first
        @results.delete(:publications)
        create
    else
      respond_to do |format|
        format.js
      end
    end
  end
 
  private
  
  def results_from_publication
    publication = params[:tup][:publication]
    publication.blank? ? { publication:"" } : Day.parse(publication).find_dates_from_publication
  end
  
  def results_from_legal_effect
    Day.parse(params[:tup][:legal_effect]).find_dates_from_legal_effect
  end
  
  def tup_params
    params.require(:tup).permit(:publication, :legal_effect)
  end
end
