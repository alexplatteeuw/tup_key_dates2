class Company < ApplicationRecord
  belongs_to :user
  belongs_to :tup, optional: true

  validates :name, :siren, :headquarters, :legal_form, :share_capital, presence: true
end
