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

    @tup = if tup_params[:publication]
      PublicationDate.find_key_dates(tup_params[:publication])
    elsif tup_params[:legal_effect]
      LegalEffectDate.find_key_dates(tup_params[:legal_effect])
    end
    
    respond_to do |format|

      if @tup.opposition_end.day_off?

        format.js   { render 'errors'}

      elsif @tup.publications&.size&.> 1

        format.js   { render 'display_publications' }

      elsif @tup.valid?

        format.js   { render 'create'}
        format.html { render 'show'}

      end
    end
  end

private

  def tup_params
    params.require(:tup).permit(:publication, :legal_effect)
  end
end
