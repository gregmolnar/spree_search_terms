class Spree::SearchTerm < ActiveRecord::Base
  attr_accessible :term, :counter, :product_id
end
