class Company < ApplicationRecord
  belongs_to :user

  before_destroy :delete_associated_tups

  has_many :company_tups, dependent: :delete_all
  has_many :tups, through: :company_tups

  validates :name, :siren, :headquarters, :legal_form, :share_capital, presence: true

  # CALLBACKS

  # delete every TUP attached to the company when the company is deleted
  def delete_associated_tups
    tups.each(&:destroy)
  end
end
