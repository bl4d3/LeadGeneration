xml.instruct!
xml.urlset "xmlns" => "http://www.sitemaps.org/schemas/sitemap/0.9" do

  xml.url do
    xml.loc root_url.chop
    xml.priority 1.0
  end

  @containers.each do |container|
    xml.url do
      xml.loc root_url.chop+frontend_path(container)
      xml.priority 0.9
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