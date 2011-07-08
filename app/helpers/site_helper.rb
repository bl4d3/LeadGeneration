module SiteHelper
	def root_node(name)
		r = "<ul>"
		places = Place.where(:name => name)
		unless places.blank?
			places.first.containers.order("order_show ASC").each do |node|
			  if node.is_public.to_i==1
  				r += "<li>"
  				if node.name.downcase == "segnala azienda"
  				  r += link_to node.name, new_company_frontends_path
  			  elsif node.name.downcase == "preventivi"
  			    r += link_to node.name, new_estimate_frontends_path
          elsif node.name.downcase == "blog"
  			    r += link_to node.name, blog_frontends_path  			    
  				else  
  				  r += link_to node.name, frontend_path(node)
  			  end
  				r += "</li>"
			  end
			end
		end
		r += "</ul>"
	end
	
	def sub_nav(name)
		r = ""
		places = Place.where(:name => name)
		unless places.blank?
			places.first.containers.order("order_show ASC").each do |node|
				r += "<div class=\"item\">"
				if node.place_holder == "estimate_wedding"
				  r += link_to "<h1>#{node.name}</h1>".html_safe, new_estimate_frontends_path				  
				else
				  r += link_to "<h1>#{node.name}</h1>".html_safe, frontend_path(node)
			  end
			  
			  unless node.sub_title.blank?
			    r += "<div class=\"hint\">#{node.sub_title}</h2></div>"
		    else
		      r += "<div class=\"hint\">Idee per le nozze</h2></div>"
		    end
				r += "</div>"
			end
		end
		return r
	end
	
	def footer_nav(name)
		r = ""
		places = Place.where(:name => name)
		unless places.blank?
			places.first.containers.order("order_show ASC").each do |node|
				r += "<ul>"
				if node.place_holder == "login"
				  r += "<li>#{link_to node.name, new_user_session_path}</li>"
				elsif node.place_holder == "forgot_password"
  				r += "<li>#{link_to node.name, new_user_password_path}</li>"
        elsif node.place_holder == "registration"
    			r += "<li>#{link_to node.name, new_user_registration_path}</li>"
				else
				  r += "<li>#{link_to node.name, frontend_path(node)}</li>"
			  end
				r += "</ul>"
			end
		end
		return r
	end	
	
	def categories_first_level(desc="")
	  r = "<ul>"  
	  Category.all.each do |category|
      r += "<li>"
      if desc==""
        r += "<div class='title'>#{link_to category.title, category_frontend_category_companies_path(category)}</div>"
      else
        r += "<div class='title'>Categoria: #{link_to category.title, category_frontend_category_companies_path(category)}</div>"
      end
      if desc==""
      elsif desc=="strip"
        r += "<div>#{truncate(category.description, :length=>400)}</strong></div>" 
      elsif desc=="desc"
        r += "<div>#{category.description}</div>" 
      end
      r += "</li>"
    end
    r += "</ul>"
    return r
	end
	
	def questions_link
   r = "<div style='margin-left:10px'>"
   r += "<h3>Link Veloci</h3>"
   r_q = Container.where(:place_holder => "questions_in_relevance").first
   n_q = Container.where(:place_holder => "new_question").first
	 r += "<ul><li>#{link_to r_q.name, frontend_path(r_q)}</li>"
	 r += "<li>#{link_to n_q.name, frontend_path(n_q)}</li></ul>"
   r += "</div>" 
   return r
	end
	
	# blog
	def arguments
   r = "<ul class=\"arguments\">"
	 Argument.all.each do |argument|
	   r += "<li>#{link_to argument.name, blog_argument_frontend_path(argument)}</li>"
   end
   r += "</ul>"
   return r
	end
	
	def last_questions(limit)
   r = "<ul class=\"arguments\">"
   container = Container.where(:place_holder => "show_question").first
	 Question.order("created_at DESC").limit(limit).each do |question|
	   r += "<li>#{link_to truncate(question.title, :length=>80), frontend_question_question_path(question)}</li>"
   end
   r += "</ul>"
   return r
	end	
	
	# fix text...
	def fix_text(text)
	  return text.html_safe
  end
  
	def social_network
		url = request.url

		r = "<table border=0 cellpadding=5 cellspacing=5><tr>"
		#facebbok
		r += '<td><script src="http://connect.facebook.net/en_US/all.js#xfbml=1"></script><fb:like href="'
		r += url.to_s
		r += '" layout="box_count" show_faces="true" font=""></fb:like></td>'
		#twitter
		r += '<td><a href="http://twitter.com/share" class="twitter-share-button" data-count="vertical" data-lang="it">Tweet</a><script type="text/javascript" src="http://platform.twitter.com/widgets.js"></script></td>'
		#buzz
		#r += '<td><a title="Posta su Google Buzz" class="google-buzz-button" href="http://www.google.com/buzz/post" data-button-style="normal-count" data-locale="it"></a>
#<script type="text/javascript" src="http://www.google.com/buzz/api/button.js"></script></td>'

		r += '<td><g:plusone size="tall"></g:plusone></td>'
		r += '</tr></table>'
		r += "<script type=\"text/javascript\" src=\"http://apis.google.com/js/plusone.js\">{lang: 'it'}</script>"
	end
	
	def last_post(n)
	  if n.blank?
	    posts = Post.where(:is_public => 1).order("created_at DESC")
    else
	    posts = Post.where(:is_public => 1).limit(n).order("created_at DESC")
    end
    r = ""
    posts.each_with_index do |post,index|
      if index == 1
        r += "<div class=\"item borded_pink\">"
      else
        r += "<div class=\"item \">"
      end
      r += "<h1>#{link_to post.title, blog_post_frontend_path(post)}</h1>"
      r += "#{image_tag post.cover_imege, :style=>'margin-top:5px;'}" unless post.cover_imege.blank?
      r += "<p>#{post.intro}</p>"
      r += "</div>"
    end
    return r
  end
  
  def provider_icon(provider)
    case provider.downcase
      when "facebook"
        image_tag "site/social_32/facebook.png", :width=>18
      when "twitter"
        image_tag "site/social_32/twitter.png", :width=>18
      when "yahoo"
        image_tag "site/social_32/yahoo.png", :width=>18
      else
        ""
    end
  end
  
  def difference_date(date,type="f")
    type=="f" ? r="inserita " : r="inserito "
		d = Date.today-date.to_date
		if d.to_i == 0
			r += "oggi"
		else
		  d.to_i==1 ? r += "#{d.to_i} giorno fa" : r += "#{d.to_i} giorni fa"
		end
    return r
  end
  
  def f_date(date)
    date.strftime("%m/%d/%Y")
  end
end