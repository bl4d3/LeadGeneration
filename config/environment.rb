# Load the rails application
require File.expand_path('../application', __FILE__)
ENV['RAILS_ENV'] ||= 'production'


PP_QUESTIONS = 10
QUESTIONS_IN_FOOTER = 5
PP_COMPANIES = 5
SEND_MAIL = true
SEND_REPORT_ADMIN = true
ESTIMATE_FOR_COMPANY = 3
MAIL_FROM = "info@matrimonioidee.it"
MAIL_TO = "mattia.lipreri@gmail.com"
MAX_CATEGORIES_FOR_COMAPNY = 4
MAX_DEPARTMENTS_FOR_COMAPNY = 4
# Initialize the rails application
LeadGeneration::Application.initialize!

ActionView::Base.field_error_proc = Proc.new do |html_tag, instance| 
  if html_tag =~ /<label/
    %|<div class="fieldWithErrors">#{html_tag} <span class="error">#{[instance.error_message].join(', ')}</span></div>|.html_safe
  else
    html_tag
  end
end
