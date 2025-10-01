#!/usr/bin/env ruby
# Test Email Configuration
# Run with: bin/rails runner test_email.rb

puts "=== TESTING EMAIL CONFIGURATION ==="
puts

begin
  # Test email delivery
  puts "Sending test email..."
  ContactMailer.contact_email(
    name: "Test User",
    email: "test@example.com",
    message: "This is a test email to verify the configuration is working."
  ).deliver_now

  puts "✅ SUCCESS: Test email sent successfully!"
  puts "Check your inbox for the test email."

rescue Net::SMTPAuthenticationError => e
  puts "❌ AUTHENTICATION ERROR: #{e.message}"
  puts "   - Check your SMTP_USERNAME and SMTP_PASSWORD"
  puts "   - For Gmail, make sure you're using an App Password"

rescue Net::SMTPError => e
  puts "❌ SMTP ERROR: #{e.message}"
  puts "   - Check your SMTP settings"

rescue => e
  puts "❌ ERROR: #{e.message}"
  puts "   - Check your email configuration"
end

puts
puts "=== CURRENT CONFIGURATION ==="
puts "CONTACT_TO_EMAIL: #{ENV['CONTACT_TO_EMAIL'] || 'NOT SET'}"
puts "CONTACT_FROM_EMAIL: #{ENV['CONTACT_FROM_EMAIL'] || 'NOT SET'}"
puts "SMTP_USERNAME: #{ENV['SMTP_USERNAME'] || 'NOT SET'}"
puts "SMTP_PASSWORD: #{ENV['SMTP_PASSWORD'] ? '[SET]' : 'NOT SET'}"
