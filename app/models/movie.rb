class Movie < ApplicationRecord
  
  has_many :rentals
  
  
  validates :title, :overview, :release_date, :inventory, presence: true
  
  validates :inventory, numericality: true
  
  validates_numericality_of :inventory, greater_than_or_equal_to: 0

end
