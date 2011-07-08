module EstimatesHelper
  def humanize_estimate(estimate)
    r = "<table width='100%'>"
    r += "<tr><td>ID</td><td>NAME</td><td>LASTNAME</td><td>ADDRESS</td><td>CITY</td><td>EMAIL</td><td>PHONE</td><td>NOTE</td><td>CATEGORIES</td></tr>"
    
    r += "<tr>"
    r += "<td>#{estimate.id}</td>"
    r += "<td>#{estimate.name}</td>"
    r += "<td>#{estimate.lastname}</td>"
    r += "<td>#{estimate.address}</td>"
    r += "<td>#{estimate.city.name}</td>"
    r += "<td>#{estimate.email}</td>"
    r += "<td>#{estimate.phone}</td>"
    r += "<td>#{estimate.note}</td>"
    r += "<td>#{estimate.categories.map(&:title).join(",")}</td>"
    r += "</tr>"
  
    r += "</table>"
    return r
  end
end
