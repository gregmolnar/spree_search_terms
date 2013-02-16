class CreateSearchTermsTable < ActiveRecord::Migration
  def change
  	create_table :spree_search_terms do |t|
  		t.integer :product_id
  		t.string :term
  		t.integer :counter 
  	end
  end
end
