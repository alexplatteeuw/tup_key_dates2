class Company < ApplicationRecord
  belongs_to :user
  has_many :company_tups
  has_many :tups, through: :company_tups

  validates :name, :siren, :headquarters, :legal_form, :share_capital, presence: true
end
