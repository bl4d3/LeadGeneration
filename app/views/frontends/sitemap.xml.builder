xml.instruct!
xml.urlset "xmlns" => "http://www.sitemaps.org/schemas/sitemap/0.9" do

  xml.url do
    xml.loc root_url.chop
    xml.priority 1.0
  end
  
  #static root
  xml.url do
    xml.loc root_url.chop+new_company_frontends_path
    xml.priority 1.0
  end
  
  xml.url do
    xml.loc root_url.chop+new_estimate_frontends_path
    xml.priority 1.0
  end
  
  xml.url do
    xml.loc root_url.chop+blog_frontends_path
    xml.priority 1.0
  end
  
  #end static root
  

  @containers.each do |container|
    xml.url do
      url_to_s = frontend_path(container).to_s
          unless ["/organizzare-matrimonio/13-login-aziende","/organizzare-matrimonio/10-blog-matrimonio","/organizzare-matrimonio/8-preventivi","/organizzare-matrimonio/20-domande-utente-matrimonio","/organizzare-matrimonio/2-preventivi-matrimonio","/organizzare-matrimonio/9-segnala-azienda-matrimonio","/organizzare-matrimonio/16-recupera-password"].include?(url_to_s)
        xml.loc root_url.chop+frontend_path(container)
        xml.priority 0.9
      end
    end
  end

  @posts.each do |post|
    xml.url do
      xml.loc root_url.chop+blog_post_frontend_path(post)
      xml.priority 0.9
    end
  end

  @categories.each do |category|
    xml.url do
      xml.loc root_url.chop+category_frontend_category_companies_path(category)
      xml.priority 0.9
    end
  end

  @companies.each do |company|
    xml.url do
      xml.loc root_url.chop+frontend_company_company_path(company)
      xml.priority 0.9
    end
  end

  @questions.each do |question|
    xml.url do
      xml.loc root_url.chop+frontend_question_question_path(question)
      xml.priority 0.9
    end
  end
end