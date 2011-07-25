# Load the rails application
require File.expand_path('../application', __FILE__)
ENV['RAILS_ENV'] ||= 'production'


PP_QUESTIONS = 10
QUESTIONS_IN_FOOTER = 5
PP_COMPANIES = 5
SEND_MAIL = true # send email to companies
SEND_REPORT_ADMIN = true # send notidication email to admin
ESTIMATE_FOR_COMPANY = 3 # max number of estimates sent out for
MAIL_FROM = "info@matrimonioidee.it"
MAIL_TO = "info@nerdydog.it"
MAX_CATEGORIES_FOR_COMAPNY = 4 # max numeber of categories for company
MAX_DEPARTMENTS_FOR_COMAPNY = 4 # max number of departments (province) for companies
# Initialize the rails application
LeadGeneration::Application.initialize!

ActionView::Base.field_error_proc = Proc.new do |html_tag, instance| 
  if html_tag =~ /<label/
    %|<div class="fieldWithErrors">#{html_tag} <span class="error">#{[instance.error_message].join(', ')}</span></div>|.html_safe
  else
    html_tag
  end
end
