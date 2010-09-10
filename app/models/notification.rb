class Notification < ActionMailer::Base 
  def generate_mail_data(sender, recipients, subject = "", body = nil, sent_on = Time.now )
    @recipients    = recipients
    @from          = sender
    @subject       = subject
    @sent_on       = sent_on
    @body          = body
  end
  
  def challenge_email(sender, recipients,subject,body_data)
    generate_mail_data(sender, recipients, subject, body_data)
  end    

end
