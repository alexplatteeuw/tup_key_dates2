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
    @key_dates = build_key_dates(tup_params[:publication] || tup_params[:legal_effect] )
    @tup = build_tup
    
    respond_to do |format|

      if !@key_dates.include_valid_opposition_end?

        format.js { render 'errors'}

      elsif @key_dates.include_many_publications?

        format.js { render 'display_publications' }

      elsif @tup.valid?

        format.js { render 'create'}
        format.html { render 'show'}

      end
    end
  end

private
  
  def build_key_dates(date)
    if tup_params[:publication]
      Date.parse(date).find_dates_from_publication
    elsif tup_params[:legal_effect]
      Date.parse(date).find_dates_from_legal_effect
    end
  end

  def build_tup
    Tup.new(
      publication:      @key_dates.publication, 
      opposition_start: @key_dates.opposition_start,
      opposition_end:   @key_dates.opposition_end,
      legal_effect:     @key_dates.legal_effect
    )
  end
  
  def tup_params
    params.require(:tup).permit(:publication, :legal_effect)
  end
end
