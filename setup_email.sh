#!/bin/bash

echo "=== EMAIL CONFIGURATION SETUP ==="
echo

# Check if .env file exists
if [ ! -f .env ]; then
    echo "Creating .env file..."
    touch .env
fi

echo "Please provide your email configuration:"
echo

# Get email settings from user
read -p "Your email address (where contact forms will be sent): " CONTACT_TO_EMAIL
read -p "From email address (can be same as above): " CONTACT_FROM_EMAIL
read -p "SMTP username (usually your email): " SMTP_USERNAME
read -s -p "SMTP password (use App Password for Gmail): " SMTP_PASSWORD
echo

# Write to .env file
cat > .env << EOF
# Email Configuration
CONTACT_TO_EMAIL=$CONTACT_TO_EMAIL
CONTACT_FROM_EMAIL=$CONTACT_FROM_EMAIL
SMTP_USERNAME=$SMTP_USERNAME
SMTP_PASSWORD=$SMTP_PASSWORD
SMTP_ADDRESS=smtp.gmail.com
SMTP_PORT=587
EOF

echo
echo "✅ Email configuration saved to .env file"
echo
echo "=== NEXT STEPS ==="
echo "1. For Gmail users:"
echo "   - Enable 2-Factor Authentication"
echo "   - Generate App Password: https://myaccount.google.com/apppasswords"
echo "   - Use the App Password (not your regular password)"
echo
echo "2. Load the environment variables:"
echo "   source .env"
echo
echo "3. Test the configuration:"
echo "   bin/rails runner \"ContactMailer.contact_email(name: 'Test', email: 'test@example.com', message: 'Test message').deliver_now\""
echo
echo "4. Restart your Rails server:"
echo "   pkill -f 'rails server' && bin/rails server -p 3002"
