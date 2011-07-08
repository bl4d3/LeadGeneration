module ApplicationHelper
	def link_to_remove_fields(name, f)
		f.hidden_field(:_destroy) + link_to_function(name, "remove_fields(this)")
	end
	
	def link_to_add_fields(name, f, association)

		new_object = f.object.class.reflect_on_association(association).klass.new
		#new_object = association.to_s.singularize.capitalize.constantize.reflect_on_association(association)
		fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
			render(association.to_s.singularize + "_fields", :f => builder)
		end
		link_to_function(name, ("add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")"))
	end
	
	def sexy_link_to (value ="", img = "tick", status = "standard", options = {}, html_options = {})
	    html_options[:class] = status
	    link_to (image_tag("icon_set/24x24/"+img+".png", :alt => "") + value), options, html_options
	end	

end
