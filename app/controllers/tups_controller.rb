class TupsController < ApplicationController

  before_action :set_date_input, :find_current_user_companies, :set_companies_ids, only: [:new, :create]

  def new
    @tup = Tup.new
    render 'new', locals: { partial_name: nil }
  end

  def create
    build_tup

    # if  @tup.errors.messages.present?
    #   render 'new'

    if @tup.valid? && @tup.opposition_end.day_off?
      respond_to do |format|
        format.html { render 'new', locals: { partial_name: 'legal_effect_warning' } }
        format.js   { render 'results', locals: { partial_name: 'legal_effect_warning' } }
      end

    elsif @tup.valid? && @tup.publications?
      render 'new', locals: { partial_name: nil }

    elsif @tup.save
      respond_to do |format|
        format.html { render 'new', locals: { partial_name: 'key_dates' } }
        format.js   { render 'results', locals: { partial_name: 'key_dates' } }
      end

    else
      respond_to do |format|
        format.html { render 'new', locals: { partial_name: 'tup_errors' } }
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
    @merging_company_id  = params.dig(:tup, :merging_company_id)
    @absorbed_company_id = params.dig(:tup, :absorbed_company_id)
  end

  def find_current_user_companies
    @companies = current_user.companies.sort_by(&:name)
  end

  def set_date_input
    @date_input = (params[:tup]&.keys || params.values).select! { |v| v == 'publication' ||  v == 'legal_effect' }.first
  end

  def set_key_dates
    if tup_params.include?(:publication)

      @tup = Tup.build_from_publication(tup_params[:publication])

    elsif tup_params.include?(:legal_effect)

      @tup = Tup.build_from_legal_effect(tup_params[:legal_effect])

    end
  end

  def set_involved_companies
    @tup.companies = Company.find([tup_params[:merging_company_id], tup_params[:absorbed_company_id]])
  end

  def tup_params
    params.require(:tup).permit(:publication, :legal_effect, :merging_company_id, :absorbed_company_id)
  end
end
