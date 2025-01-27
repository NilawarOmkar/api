class Loan < ApplicationRecord
  has_one :financial, dependent: :destroy
  has_one :location, dependent: :destroy

  accepts_nested_attributes_for :financial, :location
end
