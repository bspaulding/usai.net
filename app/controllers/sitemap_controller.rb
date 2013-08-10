class SitemapController < ApplicationController
  def sitemap
    @sections = Section.find(:all, :order => "updated_at DESC")
    
    # set content type
    headers["Content-Type"] = "text/xml"
    
    # set last modified header to the date of the latest entry
    sections_last_modified = @sections[0].updated_at
    categories_last_modified = Category.find(:first, :order => "updated_at DESC").updated_at
    pages_last_modified = Page.find(:first, :order => "updated_at DESC").updated_at
    
    last_modified = sections_last_modified.httpdate
    last_modified = categories_last_modified.httpdate if categories_last_modified > sections_last_modified
    last_modified = pages_last_modified.httpdate if pages_last_modified > categories_last_modified
    
    headers["Last-Modified"] = last_modified
  end

end
