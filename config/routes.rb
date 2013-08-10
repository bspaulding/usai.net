ActionController::Routing::Routes.draw do |map|
  map.connect '/admin/:action', :controller => 'admin'
 
  map.connect '/legal.html', :controller => 'pages', :action => 'show', :id => 23
  map.connect '/tos.html', :controller => 'pages', :action => 'show', :id => 24
 
  map.connect 'locator/', :controller => 'locator'
  map.connect 'feeds/', :controller => 'feeds'
  map.connect '/news', :controller => 'news_items', :action => 'index'
  map.connect '/partners', :controller => 'testimonials', :action => 'partners'
  map.connect '/clients', :controller => 'testimonials', :action => 'clients'
  map.connect '/search', :controller => "search"
  map.connect '/sitemap.xml', :controller => 'sitemap', :action => 'sitemap', :format => 'xml'
  map.connect '/pages/sort/:id', :controller => 'pages', :action => 'sort'
  
  map.connect '/tickers/news', :controller => 'tickers', :action => 'news'
  map.connect '/tickers/testimonials', :controller => 'tickers', :action => 'testimonials'
  
  map.resources :sections, :has_many => :categories
  map.connect '/sections/set_section_name', :controller => 'sections', :action => 'set_section_name'
  
  map.resources :categories, :belongs_to => :section, :has_many => :pages
  map.connect '/categories/sort', :controller => 'categories', :action => 'sort'
  
  map.resources :pages, :belongs_to => :category
  map.resources :news_items
  map.resources :testimonials
  #map.resources :feeds
  
  map.section_by_name '/:section_name/', :controller => 'sections', :action => 'show'
  map.category_by_name '/:section_name/:category_name/', :controller => 'categories', :action => 'show'
  map.page_by_name '/:section_name/:category_name/:page_name', :controller => 'pages', :action => 'show'
  
  map.root :controller => "sections"
  
  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing or commenting them out if you're using named routes and resources.
  #map.connect ':controller/:action/:id'
  #map.connect ':controller/:action/:id.:format'
end
