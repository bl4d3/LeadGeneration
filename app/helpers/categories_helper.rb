module CategoriesHelper
  #  -{category(['title','description'], [])}-
  # '\b(?:-{(?:\W+\w+){1,3}\W+}-\b'
  def category(params,types)
    types.blank? ? categories = Category.all : categories = Category.where(:title => types)
	  r = "<ul>"  
	  categories.all.each do |category|
      r += "<li>"
      r += "#{link_to category.title, category_frontend_category_companies_path(category)}" if params.include?("title")
      r += "#{category.description}" if params.include?("description")
      r += "</li>"
    end
    r += "</ul>"
    return r
	end
end
