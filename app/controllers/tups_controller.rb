class TupsController < ApplicationController

  before_action :set_date_type, :set_companies, :set_companies_ids, only: [:new, :create]

  def new
    @tup = Tup.new
  end

  def create
    build_tup

    if  @tup.errors.messages.present?
      render 'new'

    elsif @tup.valid? && @tup.opposition_end.day_off?
      respond_to do |format|
        format.js   { render 'results', locals: { partial_name: 'legal_effect_warning' } }
      end

    elsif @tup.valid? && @tup.publications?
      render 'new'

    elsif @tup.save
      respond_to do |format|
        format.js   { render 'results', locals: { partial_name: 'key_dates' } }
      end

    else
      respond_to do |format|
        format.js   { render 'results', locals: { partial_name: 'tup_errors' } }
      end
    end
  end

  def destroy
    @tup = Tup.find(params[:id])
    @tup.destroy
    redirect_back(fallback_location: :back)
  end

private

  def build_tup
    set_key_dates
    set_involved_companies
  end

  def set_companies_ids
    @merging_id,  @absorbed_id = companies_ids.first, companies_ids.last if params[:tup]
  end

  def set_companies
    @companies = Company.all.where(user_id: current_user.id).sort_by { |company| company.name }
  end

  def set_date_type
    @date_type = 
    
    if params[:d]
      params[:d]
    elsif params.dig(:tup, :legal_effect)
      :legal_effect
    elsif params.dig(:tup, :publication)
      :publication
    else
      nil
    end
  end

  def set_key_dates
    if tup_params.include?(:publication)

      @tup = Tup.build_from_publication(tup_params[:publication])

    elsif tup_params.include?(:legal_effect)

      @tup = Tup.build_from_legal_effect(tup_params[:legal_effect])

    end
  end

  def set_involved_companies
    @tup.companies = Company.find(companies_ids) unless companies_ids.blank?
  end

  def tup_params
    params.require(:tup).permit(:publication, :legal_effect, company_ids: [])
  end

  def companies_ids
    tup_params[:company_ids].reject { |id| id.blank? }
  end
end
