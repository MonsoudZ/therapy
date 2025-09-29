# Production Deployment Guide

This guide will help you deploy your therapy website to production.

## 🚀 Quick Deploy Options

### Option 1: Railway (Recommended - Easiest)
1. Go to [Railway.app](https://railway.app)
2. Connect your GitHub repository
3. Set environment variables (see below)
4. Deploy automatically

### Option 2: Heroku
1. Install Heroku CLI
2. Create new app: `heroku create your-app-name`
3. Set environment variables
4. Deploy: `git push heroku main`

### Option 3: DigitalOcean App Platform
1. Go to DigitalOcean App Platform
2. Connect GitHub repository
3. Configure environment variables
4. Deploy

## 📧 Email Configuration

### Gmail/Google Workspace (Easiest)
1. Enable 2-factor authentication on your Google account
2. Generate an "App Password" for this application
3. Use these settings:
   ```
   SMTP_USERNAME=your-email@gmail.com
   SMTP_PASSWORD=your-16-character-app-password
   SMTP_ADDRESS=smtp.gmail.com
   SMTP_PORT=587
   ```

### SendGrid (Recommended for production)
1. Sign up at [SendGrid.com](https://sendgrid.com)
2. Create an API key
3. Use these settings:
   ```
   SMTP_USERNAME=apikey
   SMTP_PASSWORD=your-sendgrid-api-key
   SMTP_ADDRESS=smtp.sendgrid.net
   SMTP_PORT=587
   ```

## 🔧 Environment Variables

Set these in your hosting platform:

### Required Variables
```
RAILS_ENV=production
RAILS_HOST=your-domain.com
SECRET_KEY_BASE=generate-with-rails-secret
RAILS_MASTER_KEY=your-master-key
```

### Email Variables
```
CONTACT_TO_EMAIL=angela@angelakeeley.com
CONTACT_FROM_EMAIL=noreply@your-domain.com
SMTP_USERNAME=your-smtp-username
SMTP_PASSWORD=your-smtp-password
SMTP_ADDRESS=your-smtp-server
SMTP_PORT=587
```

## 🗄️ Database Setup

### For SQLite (Default - Good for small sites)
No additional setup needed. SQLite files will be created automatically.

### For PostgreSQL (Recommended for larger sites)
1. Add PostgreSQL addon to your hosting platform
2. Set `DATABASE_URL` environment variable
3. Update `config/database.yml` for PostgreSQL

## 🔐 Security Setup

### 1. Generate Secret Key
```bash
rails secret
```
Use this as your `SECRET_KEY_BASE`

### 2. Set up Admin User
After deployment, run:
```bash
rails console
Admin.create!(email: "admin@angelakeeley.com", password: "secure-password", password_confirmation: "secure-password")
```

### 3. Update Contact Credentials
Edit `config/credentials.yml.enc`:
```bash
rails credentials:edit
```

Add:
```yaml
contact:
  to_email: angela@angelakeeley.com
  from_email: noreply@your-domain.com
```

## 📱 Domain Setup

### 1. Custom Domain
1. Point your domain to your hosting platform
2. Set `RAILS_HOST` to your domain
3. Enable SSL/HTTPS

### 2. Subdomain (if using hosting platform domain)
Set `RAILS_HOST` to your subdomain (e.g., `therapy.railway.app`)

## 🧪 Testing Production

### 1. Health Check
Visit: `https://your-domain.com/up`

### 2. Test Contact Form
1. Go to contact page
2. Fill out and submit form
3. Check that email is received

### 3. Test Admin Panel
1. Go to `/admins/sign_in`
2. Login with admin credentials
3. Test content management

## 🔍 Monitoring

### 1. Logs
Check your hosting platform's logs for any errors

### 2. Performance
Monitor response times and memory usage

### 3. Email Delivery
Test contact form regularly to ensure emails are being sent

## 🚨 Troubleshooting

### Common Issues

1. **Email not sending**
   - Check SMTP credentials
   - Verify email provider settings
   - Check spam folder

2. **Admin login not working**
   - Ensure admin user exists
   - Check password is correct
   - Verify email format

3. **Site not loading**
   - Check `RAILS_HOST` environment variable
   - Verify domain DNS settings
   - Check hosting platform status

### Getting Help
- Check hosting platform documentation
- Review Rails logs
- Test locally first

## 📈 Performance Tips

1. **Enable caching** (already configured)
2. **Use CDN** for static assets
3. **Monitor database** performance
4. **Set up backups** for database

## 🔄 Updates

To update your site:
1. Push changes to GitHub
2. Your hosting platform will auto-deploy
3. Run migrations if needed: `rails db:migrate`

## 📞 Support

For technical issues:
1. Check this guide first
2. Review hosting platform docs
3. Check Rails logs
4. Test locally to isolate issues
