require_relative '../conf.rb'
require 'pony'

def send_email(to, title, body)
  Pony.mail({
    from: Configuration[:email][:sender],
    to: to,
    subject: title,
    body: body,
    via: :smtp,
    via_options: Configuration[:email][:smtp]
  })
end

