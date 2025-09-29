# Railway Deployment Fixes

## 🔧 **Health Check Issues Fixed**

### **Problem**: Health check failing at `/up`
### **Solution**: Multiple fixes applied

## **1. Environment Variables to Set in Railway**

Go to Railway Dashboard → Your Project → Variables and add:

```bash
# Rails Configuration
RAILS_ENV=production
RAILS_LOG_LEVEL=info
RAILS_HOST=columbinetherapy.com
RAILS_SERVE_STATIC_FILES=true
RAILS_SERVE_STATIC_ASSETS=true

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

## **2. Railway Configuration Updates**

- ✅ Increased health check timeout to 300 seconds
- ✅ Fixed production database configuration
- ✅ Added static file serving
- ✅ Created production startup script

## **3. Common Railway Issues & Solutions**

### **Issue**: App won't start
**Solution**: Check environment variables are set correctly

### **Issue**: Database errors
**Solution**: Ensure `RAILS_ENV=production` is set

### **Issue**: Static files not loading
**Solution**: Set `RAILS_SERVE_STATIC_FILES=true`

### **Issue**: Health check timeout
**Solution**: Increased timeout to 300 seconds

## **4. Deployment Steps**

1. **Push changes to GitHub**:
   ```bash
   git add .
   git commit -m "Fix Railway deployment issues"
   git push origin main
   ```

2. **Set environment variables** in Railway dashboard

3. **Redeploy** - Railway will auto-deploy from GitHub

4. **Check logs** in Railway dashboard for any errors

## **5. Testing the Deployment**

1. **Health check**: `https://your-app.railway.app/up`
2. **Main site**: `https://your-app.railway.app`
3. **Admin panel**: `https://your-app.railway.app/admin`

## **6. If Still Failing**

Check Railway logs for specific errors:
- Database connection issues
- Missing environment variables
- Asset compilation errors
- Port binding issues

## **7. Alternative: Use Render Instead**

If Railway continues to have issues, try Render:
1. Go to [render.com](https://render.com)
2. Connect GitHub repo
3. Use same environment variables
4. Render is often more reliable for Rails apps
