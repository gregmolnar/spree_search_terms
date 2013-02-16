Deface::Override.new(:virtual_path => "spree/products/show", 
			         :name => "search_terms", 
			         :insert_after => "[data-hook='product_description']",
			         :partial => 'spree/search_terms/search_terms'
					)