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

    @tup = publication ? TupFromPublication.build(publication) : TupFromLegalEffect.build(legal_effect)

    respond_to do |format|

      if @tup.opposition_end.day_off?

        format.js   { render 'legal_effect_warning'}
        format.html { render 'show'}

      elsif @tup.publications&.size&.> 1

        format.js   { render 'publications_options' }
        format.html { render 'show'}

      elsif @tup.save

        format.js   { render 'key_dates'}
        format.html { render 'show'}

      end
    end
  end

private

  def tup_params
    params.require(:tup).permit(:publication, :legal_effect)
  end
  
  def publication
    tup_params[:publication]
  end
  
  def legal_effect
    tup_params[:legal_effect]
  end
end
