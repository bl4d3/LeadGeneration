class Notification < ActionMailer::Base
  add_template_helper(EstimatesHelper)
  add_template_helper(CompaniesHelper)
  
  default :from => "info@nerdydog.it"
  
  def welcome_email
    @user = "user"
    @url  = "http://example.com/login"
    mail(:to => "mattia.lipreri@gmail.com",
         :subject => "Welcome to My Awesome Site")
  end
  
  def estimate_admin(estimate, companies)
    @estimate = estimate
    @companies = companies
    mail(:to => "mattia.lipreri@gmail.com",
         :subject => "REPORT NUOVO PREVENTIVO")
  end
  
  def notify(action)
    @msg=""
    if action == 1
      @msg="Nuova domanda"
    elsif action == 2
      @msg="Domanda commentata"
    elsif action == 3
      @msg="Nuovo post"
    elsif action == 4
      @msg="Post commentato"
    elsif action == 5
      @msg="Nuova azienda registrata"
    elsif action == 6
      @msg="Nuova azienda segnalata"  
    elsif action == 7
      @msg="Nuova richiesta di preventivo"
    elsif action == 8
      @msg="Nuovo contatto per newsletter"      
    end
    
    mail(:to => "mattia.lipreri@gmail.com",
         :subject => "MI [#{@msg}]")
  end
  
  def notify_raw(to, from, subject, content)
    @content = content
    mail(:from => from, :to => to, :subject => subject)
  end
    
end
