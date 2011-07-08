xml.instruct! :xml, :version => "1.0" 
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "Matrimonio Idee Blog"
    xml.description "Segui il blog di matrimonio idee"
    xml.link posts_url

    for post in @posts
      xml.item do
        xml.title post.title
        xml.description post.body
        xml.pubDate post.created_at.to_s(:rfc822)
        xml.link root_url.chop+blog_post_frontend_path(post)
        xml.guid root_url.chop+blog_post_frontend_path(post)
      end
    end
  end
end
