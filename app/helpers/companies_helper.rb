module CompaniesHelper

  def humanize_companies(companies)
    r = "<table width='100%'>"
    r += "<tr><td>ID</td><td>NAME</td><td>SITE</td><td>EMAIL</td><td>CITY</td><td>DEPARTMENT</td><td>CATEGORIES</td><td>ZONES</td></tr>"
    companies.each do |company|
      r += "<tr>"
      r += "<td>#{company.id}</td>"
      r += "<td>#{company.name}</td>"
      r += "<td>#{company.url_site}</td>"
      r += "<td>#{company.email_address}</td>"
      r += "<td>#{company.city.name}</td>"
      r += "<td>#{company.city.department.name}</td>"
      r += "<td>#{company.categories.map(&:title).join(",")}</td>"
      r += "<td>#{company.departments.map(&:name).join(",")}</td>"
      r += "</tr>"
    end
    r += "</table>"
    return r
  end

end
