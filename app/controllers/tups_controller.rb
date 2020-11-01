class TupsController < ApplicationController

  def index
  end

  def new
    @tup = Tup.new
    @companies = Company.all.where(user_id: current_user.id)

    respond_to do |format|
      format.js     { render 'new', locals: { date: params[:d] } }
      format.html   { render 'new', locals: { date: params[:d] } }
    end
  end
  
  def show
    @tup = Tup.find(params[:id])
  end

  def create

    @tup = publication ? Tup.build_from_publication(publication) : Tup.build_from_legal_effect(legal_effect)

    @tup.companies << companies

    if  @tup.errors.messages.present?
      respond_to do |format|
        format.js     { render 'tup_errors'}
        format.html   { render 'new'}
      end

    elsif @tup.valid? && @tup.opposition_end.day_off?
      respond_to do |format|
        format.js   { render 'legal_effect_warning'}
        format.html { render 'show'}
      end

    elsif @tup.valid? && @tup.publications?
      respond_to do |format|
        format.js   { render 'publications_options' }
        format.html { render 'show'}
      end

    elsif @tup.save
      respond_to do |format|
        format.js   { render 'key_dates'}
        format.html { render 'show'}
      end

    else
      respond_to do |format|
        format.js   { render 'tup_errors'}
      end
    end
  end

private

  def tup_params
    params.require(:tup).permit(:publication, :legal_effect, :companies)
  end
  
  def publication
    tup_params[:publication]
  end
  
  def legal_effect
    tup_params[:legal_effect]
  end

  def companies
    params.require(:tup)[:companies].reject { |c| c.empty? }.map  { |c| Company.find(c) }
  end
end
