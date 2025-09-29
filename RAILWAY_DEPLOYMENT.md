# Railway Deployment Guide

## 🚀 Deploy to Railway (Free)

### Step 1: Create Railway Account
1. Go to [railway.app](https://railway.app)
2. Sign up with GitHub
3. Connect your GitHub account

### Step 2: Deploy from GitHub
1. Click "New Project"
2. Select "Deploy from GitHub repo"
3. Choose your `columbine_therapy` repository
4. Railway will automatically detect it's a Rails app

### Step 3: Configure Environment Variables
In Railway dashboard, go to your project → Variables tab and add:

```bash
# Rails Configuration
RAILS_ENV=production
RAILS_LOG_LEVEL=info
RAILS_HOST=columbinetherapy.com

# Admin Configuration
ADMIN_EMAIL=admin@columbinetherapy.com
ADMIN_PASSWORD=your_secure_password_here

# Email Configuration (Gmail)
CONTACT_TO_EMAIL=angela@columbinetherapy.com
CONTACT_FROM_EMAIL=noreply@columbinetherapy.com

# Gmail SMTP Configuration
SMTP_USERNAME=angela@columbinetherapy.com
SMTP_PASSWORD=your_gmail_app_password_here
SMTP_DOMAIN=gmail.com
SMTP_ADDRESS=smtp.gmail.com
SMTP_PORT=587
SMTP_AUTHENTICATION=plain
SMTP_ENABLE_STARTTLS_AUTO=true

# Security (generate with: rails secret)
SECRET_KEY_BASE=your_secret_key_base_here
```

### Step 4: Set Up Gmail for Email
1. Create Gmail account: `angela@columbinetherapy.com`
2. Enable 2-Factor Authentication
3. Generate App Password:
   - Go to Google Account Settings
   - Security → 2-Step Verification → App passwords
   - Generate password for "Mail"
   - Use this password for `SMTP_PASSWORD`

### Step 5: Deploy
1. Railway will automatically deploy when you push to GitHub
2. Your site will be available at: `https://your-app-name.railway.app`
3. Set up custom domain: `columbinetherapy.com`

### Step 6: Set Up Custom Domain
1. In Railway dashboard → Settings → Domains
2. Add custom domain: `columbinetherapy.com`
3. Update DNS records as instructed by Railway
4. SSL will be automatic

### Step 7: Run Database Migrations
1. In Railway dashboard → Deployments → View Logs
2. Run: `rails db:migrate`
3. Run: `rails db:seed`

### Step 8: Access Admin Panel
1. Go to: `https://columbinetherapy.com/admins/sign_in`
2. Login with:
   - Email: `admin@columbinetherapy.com`
   - Password: `your_secure_password_here`

## 🎯 What You Get
- ✅ **Free hosting** (Railway free tier)
- ✅ **Custom domain** (columbinetherapy.com)
- ✅ **SSL/HTTPS** (automatic)
- ✅ **Email notifications** (Gmail SMTP)
- ✅ **Admin panel** (content management)
- ✅ **Database** (SQLite, persistent storage)

## 📧 Email Setup
The contact form will send emails to `angela@columbinetherapy.com` when visitors submit the contact form.

## 🔧 Admin Panel
- **URL**: `https://columbinetherapy.com/admin`
- **Login**: Use the admin credentials you set
- **Features**: Edit site content, view contact requests

## 💰 Cost
- **Railway**: Free (with $5 monthly credit)
- **Domain**: You already own columbinetherapy.com
- **Email**: Free Gmail account
- **Total**: $0/month
