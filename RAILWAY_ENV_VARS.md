# Railway Environment Variables

## 🔧 **Required Railway Variables**

Set these in Railway Dashboard → Your Project → Variables:

### **Core Rails Configuration**
```bash
RAILS_ENV=production
SECRET_KEY_BASE=8880b3b5eeea7f2452b720cb4b68af44edfa22f05a11d81c95ba45d3ef0d8bd2e4ae42fa3bd4902b8df4c463fe2a137d2c4b078f30b56478cb173a2d624f585e
RAILS_SERVE_STATIC_FILES=true
RAILS_SERVE_STATIC_ASSETS=true
RAILS_LOG_TO_STDOUT=true
```

### **Database (Auto-set by Railway Postgres)**
```bash
# Railway will automatically set this when you add Postgres plugin
DATABASE_URL=postgresql://user:pass@host:port/dbname
```

### **Admin Configuration**
```bash
ADMIN_EMAIL=admin@columbinetherapy.com
ADMIN_PASSWORD=your_secure_password_here
```

### **Email Configuration**
```bash
CONTACT_TO_EMAIL=angela@columbinetherapy.com
CONTACT_FROM_EMAIL=noreply@columbinetherapy.com

# Gmail SMTP (optional)
SMTP_USERNAME=angela@columbinetherapy.com
SMTP_PASSWORD=your_gmail_app_password_here
SMTP_DOMAIN=gmail.com
SMTP_ADDRESS=smtp.gmail.com
SMTP_PORT=587
SMTP_AUTHENTICATION=plain
SMTP_ENABLE_STARTTLS_AUTO=true
```

## 🎯 **Railway Setup Steps**

### **1. Add Postgres Database**
1. Go to Railway Dashboard
2. Click "New" → "Database" → "Postgres"
3. Railway will automatically set `DATABASE_URL`

### **2. Set Environment Variables**
1. Go to your project in Railway
2. Click "Variables" tab
3. Add all the variables above
4. Save changes

### **3. Deploy**
1. Railway will auto-deploy from GitHub
2. Check logs for any errors
3. Test health endpoint: `https://your-app.railway.app/up`

## 🔍 **Common Issues**

### **SECRET_KEY_BASE Missing**
- **Error**: `KeyError: key not found: "SECRET_KEY_BASE"`
- **Fix**: Set `SECRET_KEY_BASE` variable

### **Database Connection Failed**
- **Error**: `ActiveRecord::NoDatabaseError`
- **Fix**: Add Postgres database plugin, check `DATABASE_URL`

### **Host Not Permitted**
- **Error**: `ActionController::InvalidAuthenticityToken`
- **Fix**: Already fixed with `config.hosts << ".railway.app"`

### **Static Files Not Found**
- **Error**: 404 on CSS/JS files
- **Fix**: Set `RAILS_SERVE_STATIC_FILES=true`

## 📋 **Environment Checklist**

- [ ] `RAILS_ENV=production`
- [ ] `SECRET_KEY_BASE` set (64-char hex string)
- [ ] `DATABASE_URL` set (by Railway Postgres)
- [ ] `RAILS_SERVE_STATIC_FILES=true`
- [ ] `RAILS_LOG_TO_STDOUT=true`
- [ ] Admin credentials configured
- [ ] Email settings configured (optional)

## 🚀 **Expected Deployment Flow**

1. **Build**: ✅ Dockerfile builds successfully
2. **Database**: ✅ Postgres connection established
3. **Migrations**: ✅ `rails db:prepare` runs
4. **Server**: ✅ Puma starts on `$PORT`
5. **Health**: ✅ `/up` endpoint responds
6. **Site**: ✅ Main site accessible

## 🔧 **Debug Commands**

If deployment fails, check Railway logs for:

```bash
# Check if server started
grep "Puma starting" logs

# Check database connection
grep "Database" logs

# Check health endpoint
grep "/up" logs

# Check for errors
grep "ERROR" logs
```

**Your Railway deployment should now work with these fixes!**
