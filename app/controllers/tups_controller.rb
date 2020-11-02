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
    
    build_tup

    if  @tup.errors.messages.present?
      respond_to do |format|
        format.js     { render 'new'}
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

  def build_tup
    set_key_dates
    set_involved_companies unless companies_ids.blank?
  end

  def set_key_dates
    if publication_param
      @tup = Tup.build_from_publication(publication_param)
    elsif legal_effect_param
      @tup = Tup.build_from_legal_effect(legal_effect_param)
    end
  end

  def set_involved_companies
    @tup.companies = Company.find(companies_ids)
  end

  def tup_params
    params.require(:tup).permit(:publication, :legal_effect, company_ids: [])
  end

  def publication_param
    tup_params[:publication]
  end

  def legal_effect_param
    tup_params[:legal_effect]
  end
  
  def companies_ids
    tup_params[:company_ids].reject { |id| id.blank? }
  end
end
