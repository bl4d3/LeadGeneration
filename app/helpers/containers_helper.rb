module ContainersHelper


	def link_to_container(container, owner)
		ret = render :partial => 'containers/row', :locals => { :container => container }
	end



	def display_containers(owner = 0)
		containers = Container.find(:all, :order => :order_show)
		if owner == 3
			containers = Container.find(:all, :conditions => {:user_id => current_user.id, :name => PRODUCT_ROOT}, :order => :order_show)  
		end
		
		unless containers.empty?

			ret = "<ul id=\"root\">"
			for container in containers
				if container.parent_id.nil?
					#ret += "<li>"
					#ret += "<li><a href=\"#\">"+link_to_container(container,owner)+"</a></li>"
					ret += "<li id=\"c_#{container.id}\">"+link_to_container(container,owner)
					subContainer = find_all_subcontainers(container,owner)
					unless subContainer.nil?
						ret += subContainer
						ret += "</li>"
					end
				end
			end
			ret += "</ul>"
		else
			ret = "Nessuna categoria disponibile"
		end
	end

   def find_all_subcontainers(container,owner)
	if container.children.size > 0
		  ret = "<ul id=\"p_#{container.id}\">"
		  Container.find(:all, :conditions => {:parent_id => container.id}, :order => :order_show).each{ |subcat|
		  #container.children.each { |subcat| 
			if subcat.children.size > 0
			  #ret += '<li>'
			  #ret += '<li><a href=\"#\">' + link_to_container(subcat,owner) + '</a></li>'
			  #ret += '<ul>'
			  ret += "<li id=\"c_#{subcat.id}\">"+link_to_container(subcat,owner)
			  #ret += '<ul id="p#{subcat.id}">'
			  ret += find_all_subcontainers(subcat,owner)
			  #ret += '</ul>'
			  ret += '</li>'
			else
			  #ret += '<li>'
			  #ret += '<li><a href=\"#\">' + link_to_container(subcat,owner) + '</a></li>'
			  ret += "<li id=\"c_#{subcat.id}\">"+link_to_container(subcat,owner)+"</li>"
			  #ret += '</li>'
			end
			}
		  ret += '</ul>'
	end

  end

end
