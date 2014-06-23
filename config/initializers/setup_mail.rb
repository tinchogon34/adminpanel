ActionMailer::Base.smtp_settings = {  
:address              => "localhost",  
:port                 => 25,
:enable_starttls_auto => false,
:openssl_verify_mode => OpenSSL::SSL::VERIFY_NONE 
}