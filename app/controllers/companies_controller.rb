class CompaniesController < ApplicationController
  before_action :set_company, only: [:edit, :update, :show, :destroy]

  def index
    @companies = current_user.companies.sort_by { |company| company.name }
  end

  def new
    @company = Company.new
  end

  def create
    @company         = Company.new(company_params)
    @company.user_id = current_user.id
    if @company.valid?
      @company.save
      redirect_to company_path(@company)
    else
      render 'new'
    end
  end

  def edit
  end

  def update
  end

  def show
  end

  def destroy
    @company = Company.find(params[:id])
    @company.destroy
    redirect_to companies_path
  end

  private

  def set_company
    @company = Company.find(params[:id])
  end

  def company_params
    params.require(:company).permit(:name, :siren, :headquarters, :legal_form, :share_capital)
  end
end
