xml.instruct!
xml.urlset "xmlns" => "http://www.sitemaps.org/schemas/sitemap/0.9" do
  @sections.each do |section|
    unless section.name == "Support Center"
      xml.url do
        xml.loc section_by_name_url(  :section_name => section.name.downcase.gsub(' ', '_'),
                                      :only_path => false
                                      )      
        xml.lastmod section.updated_at.to_date
      end
      
      section.categories.each do |category|
        xml.url do
          xml.loc category_by_name_url( :section_name => section.name.downcase.gsub(' ', '_'),
                                        :category_name => category.name.downcase.gsub(' ', '_'),
                                        :only_path => false)
          xml.lastmod category.updated_at.to_date
        end
        
        category.pages.each do |page|
          xml.url do
            xml.loc page_by_name_url( :section_name => section.name.downcase.gsub(' ', '_'),
                                      :category_name => category.name.downcase.gsub(' ', '_'),
                                      :page_name => page.name.downcase.gsub(' ', '_'),
                                      :only_path => false)
            xml.lastmod page.updated_at.to_date
          end
        end
      end
    end
  end
end