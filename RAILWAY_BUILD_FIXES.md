# Railway Build Fixes

## 🔧 **Common Railway Build Issues & Solutions**

### **Issue 1: Asset Precompilation Fails**
**Solution**: Added explicit build command in `railway.json`

### **Issue 2: Missing Dependencies**
**Solution**: Created `bin/railway_build` script

### **Issue 3: Static Files Not Serving**
**Solution**: Updated production environment configuration

## 🚀 **Updated Railway Configuration**

### **railway.json**
```json
{
  "$schema": "https://railway.app/railway.schema.json",
  "build": {
    "builder": "NIXPACKS",
    "buildCommand": "bundle install && bundle exec rails assets:precompile"
  },
  "deploy": {
    "startCommand": "bundle exec rails server -p $PORT -e production",
    "healthcheckPath": "/up",
    "healthcheckTimeout": 300,
    "restartPolicyType": "ON_FAILURE",
    "restartPolicyMaxRetries": 10
  }
}
```

### **Procfile**
```
web: bundle exec rails server -p $PORT -e production
```

## 🔧 **Environment Variables for Railway**

Set these in Railway dashboard → Variables:

```bash
# Rails Configuration
RAILS_ENV=production
RAILS_LOG_LEVEL=info
RAILS_HOST=columbinetherapy.com
RAILS_SERVE_STATIC_FILES=true
RAILS_SERVE_STATIC_ASSETS=true

# Database (Railway will provide DATABASE_URL automatically)
# No need to set DATABASE_URL manually

# Admin Configuration
ADMIN_EMAIL=admin@columbinetherapy.com
ADMIN_PASSWORD=your_secure_password_here

# Email Configuration
CONTACT_TO_EMAIL=angela@columbinetherapy.com
CONTACT_FROM_EMAIL=noreply@columbinetherapy.com

# Gmail SMTP
SMTP_USERNAME=angela@columbinetherapy.com
SMTP_PASSWORD=your_gmail_app_password_here
SMTP_DOMAIN=gmail.com
SMTP_ADDRESS=smtp.gmail.com
SMTP_PORT=587
SMTP_AUTHENTICATION=plain
SMTP_ENABLE_STARTTLS_AUTO=true

# Security
SECRET_KEY_BASE=115fb3e57e3374ec96ae70d0cb79cfdefdb7f575b689bbd034d3ab9e1d3b76cbc1630735e2fd681143c73bb2e0a1048250955496a470cb3a8b0bf377bff1ac09
```

## 🎯 **Deployment Steps**

1. **Push changes to GitHub**:
   ```bash
   git add .
   git commit -m "Fix Railway build issues"
   git push origin main
   ```

2. **In Railway Dashboard**:
   - Go to your project
   - Go to Settings → Variables
   - Add all environment variables above
   - Save changes

3. **Redeploy**:
   - Railway will auto-deploy from GitHub
   - Check build logs for any errors

## 🚨 **If Still Failing**

### **Check Railway Logs**:
1. Go to Railway Dashboard
2. Click on your project
3. Go to "Deployments" tab
4. Click on latest deployment
5. Check "Build Logs" for specific errors

### **Common Build Errors**:

1. **Asset precompilation fails**:
   - Check if all gems are in Gemfile
   - Ensure Node.js is available

2. **Database connection fails**:
   - Check DATABASE_URL is set
   - Verify database migrations

3. **Static files not found**:
   - Check RAILS_SERVE_STATIC_FILES=true
   - Verify assets are precompiled

## 🔄 **Alternative: Try Render Instead**

If Railway continues to fail, try Render:

1. Go to [render.com](https://render.com)
2. Connect GitHub repo
3. Use same environment variables
4. Render is often more reliable for Rails

## 📋 **Build Checklist**

- [ ] `railway.json` configured correctly
- [ ] `Procfile` updated
- [ ] Environment variables set
- [ ] Assets precompile successfully
- [ ] Database migrations run
- [ ] Health check passes

## 🎯 **Expected Build Process**

1. **Install dependencies**: `bundle install`
2. **Precompile assets**: `rails assets:precompile`
3. **Start server**: `bundle exec rails server -p $PORT -e production`
4. **Health check**: `/up` endpoint responds
5. **Site accessible**: Main site loads correctly
