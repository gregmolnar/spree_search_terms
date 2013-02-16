Spree::ProductsController.class_eval do
	before_filter :search_term, :only => :show

	def search_term
		require 'uri'
		bots = {
			'google.hu' => 'q',
			'google.com' => 'q',
			'go.google.com' => 'q',
			'images.google.com' => 'q',
			'video.google.com' => 'q',
			'news.google.com' => 'q',
			'blogsearch.google.com' => 'q',
			'maps.google.com' => 'q',
			'local.google.com' => 'q',
			'search.yahoo.com' => 'p',
			'search.msn.com' => 'q',
			'bing.com' => 'q',
			'msxml.excite.com' => 'qkw',
			'search.lycos.com' => 'query',
			'alltheweb.com' => 'q',
			'search.aol.com' => 'query',
			'search.iwon.com' => 'searchfor',
			'ask.com' => 'q',
			'ask.co.uk' => 'ask',
			'search.cometsystems.com' => 'qry',
			'hotbot.com' => 'query',
			'overture.com' => 'Keywords',
			'metacrawler.com' => 'qkw',
			'search.netscape.com' => 'query',
			'looksmart.com' => 'key',
			'dpxml.webcrawler.com' => 'qkw',
			'search.earthlink.net' => 'q',
			'search.viewpoint.com' => 'k',
			'yandex.kz' => 'text',
			'yandex.ru' => 'text',
			'baidu.com' => 'wd',			
			'mamma.com' => 'query'
		}
		parsed = URI::parse(request.referer)
		host = parsed.host.gsub(/^www\./, '')
		query = (parsed.query.nil?) ? Rack::Utils.parse_nested_query(parsed.fragment) : Rack::Utils.parse_nested_query(parsed.query)
		term = query[bots[host]]
		return true if term.nil? or term.empty?
		product = Spree::Product.active(current_currency).find_by_permalink!(params[:id])

		t = Spree::SearchTerm.where('product_id = ? and term = ?', product.id, term).first
		if t.nil?			
			Spree::SearchTerm.create({:product_id => product.id, :term => term, :counter => 1})
		else
			t.counter = t.counter+1
			t.save
		end
		return true
	end
end