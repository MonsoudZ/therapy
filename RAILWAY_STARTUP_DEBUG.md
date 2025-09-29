# Railway Startup Debug

## 🚨 **Issue**: App Not Starting After Successful Build

Railway build succeeds but app fails to start, causing healthcheck failures.

## 🔧 **Fixes Applied**

### **1. Added Server Binding**
- Added `-b 0.0.0.0` to bind to all interfaces
- Railway needs this to access the app from outside

### **2. Created Startup Debug Script**
- `bin/railway_start` script with detailed logging
- Checks environment variables
- Verifies database connection
- Runs migrations before starting

### **3. Updated Configuration**
- Railway now uses custom startup script
- Better error handling and logging
- Database migration before server start

## 🎯 **Railway Configuration**

### **railway.json**
```json
{
  "$schema": "https://railway.app/railway.schema.json",
  "build": {
    "builder": "NIXPACKS",
    "buildCommand": "bundle install && bundle exec rails assets:precompile"
  },
  "deploy": {
    "startCommand": "./bin/railway_start",
    "healthcheckPath": "/up",
    "healthcheckTimeout": 600,
    "restartPolicyType": "ON_FAILURE",
    "restartPolicyMaxRetries": 10
  }
}
```

### **bin/railway_start**
```bash
#!/usr/bin/env bash
set -e

echo "Starting Railway deployment..."

# Check environment variables
echo "Environment check:"
echo "PORT: $PORT"
echo "RAILS_ENV: $RAILS_ENV"
echo "DATABASE_URL: ${DATABASE_URL:0:20}..."

# Check if database is available
echo "Checking database connection..."
if bundle exec rails runner "puts 'Database connected successfully'"; then
  echo "✅ Database connection OK"
else
  echo "❌ Database connection failed"
  exit 1
fi

# Run database migrations
echo "Running database migrations..."
bundle exec rails db:migrate

# Start the server
echo "Starting Rails server on port $PORT..."
exec bundle exec rails server -p $PORT -e production -b 0.0.0.0
```

## 🔍 **Common Startup Issues**

### **1. Database Connection**
- **Issue**: DATABASE_URL not set or invalid
- **Fix**: Check Railway environment variables
- **Debug**: Check startup logs for database errors

### **2. Port Binding**
- **Issue**: App not binding to correct port
- **Fix**: Added `-b 0.0.0.0` flag
- **Debug**: Check if PORT environment variable is set

### **3. Missing Dependencies**
- **Issue**: Gems or dependencies not installed
- **Fix**: Check Gemfile and bundle install
- **Debug**: Check build logs for missing gems

### **4. Database Migrations**
- **Issue**: Database not migrated
- **Fix**: Added `rails db:migrate` to startup script
- **Debug**: Check migration logs

## 🚀 **Deployment Steps**

1. **Push changes**:
   ```bash
   git add .
   git commit -m "Fix Railway startup - add binding, debug script, migrations"
   git push origin main
   ```

2. **Monitor Railway logs**:
   - Go to Railway Dashboard
   - Check "Deploy Logs" for startup errors
   - Look for database connection issues

3. **Check environment variables**:
   - Ensure DATABASE_URL is set
   - Verify PORT is available
   - Check all required variables

## 🔧 **If Still Failing**

### **Check Railway Logs**:
1. Railway Dashboard → Your Project
2. Deployments → Latest deployment
3. Check "Deploy Logs" for specific errors

### **Common Error Messages**:

1. **"Database connection failed"**:
   - Check DATABASE_URL in Railway variables
   - Verify database is accessible

2. **"Port already in use"**:
   - Check if another process is using the port
   - Verify PORT environment variable

3. **"Migration failed"**:
   - Check database permissions
   - Verify database schema

### **Alternative: Try Render.com**

If Railway continues to fail, try **Render.com**:
1. Go to [render.com](https://render.com)
2. Connect GitHub repository
3. Use same environment variables
4. Render often handles Rails better

## 📋 **Startup Checklist**

- [ ] Server binds to 0.0.0.0
- [ ] PORT environment variable set
- [ ] DATABASE_URL configured
- [ ] Database migrations run
- [ ] All dependencies installed
- [ ] Health check endpoint accessible

## 🎯 **Expected Startup Process**

1. **Environment check**: ✅ Variables loaded
2. **Database connection**: ✅ Connection successful
3. **Migrations**: ✅ Database updated
4. **Server start**: ✅ Rails server running
5. **Health check**: ✅ `/up` endpoint responds

## 🔄 **Debug Commands**

If you need to debug locally:

```bash
# Test startup script locally
RAILS_ENV=production PORT=3000 ./bin/railway_start

# Check database connection
bundle exec rails runner "puts 'Database connected'"

# Test health endpoint
curl http://localhost:3000/up
```

**The startup script will now provide detailed logging to help identify exactly where the failure occurs.**
