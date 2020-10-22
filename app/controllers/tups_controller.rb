class TupsController < ApplicationController

  def index
    raise
  end
  
  def new
    @day = Day.new
  end
  
  def show
    @tup = Tup.find(params[:id])
  end

  def create
    respond_to do |format|
      if @date.valid?
        
        @tup = Tup.new(
          publication:    @date.publication, 
          opposition_start: @date.opposition_start,
          opposition_end: @date.opposition_end,
          legal_effect:   @date.legal_effect
        )

        format.js { render 'create' }
      else
        format.js { render 'errors' }
      end
    end
  end

  def compute_from_publication
    dates_from_publication
    create
  end
  
  def compute_from_legal_effect
    dates_from_legal_effect
    if @date.publication
      create
    else
      respond_to do |format|
        if @date.valid?
          format.js { render 'display_publications' }
        else
          format.js { render 'errors' }
        end
      end
    end
  end
 
  private
  
  def dates_from_publication
    publication = Day.parse(tup_params[:publication])
    @date = publication.find_dates_from_publication
  end
  
  def dates_from_legal_effect
    legal_effect = Day.parse(tup_params[:legal_effect]).find_dates_from_legal_effect
    @date = legal_effect.find_dates_from_legal_effect
  end
  
  def tup_params
    params.require(:day).permit(:publication, :legal_effect)
  end
end
