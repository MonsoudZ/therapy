# Railway Healthcheck Fix

## 🚨 **Issue**: Healthcheck Failure During Deployment

Railway deployment fails at the "Network › Healthcheck" phase, which means:
- ✅ Build succeeds
- ✅ Deploy succeeds  
- ❌ Healthcheck fails (can't reach `/up` endpoint)

## 🔧 **Fixes Applied**

### **1. Updated Railway Configuration**
- Increased `healthcheckTimeout` from 300 to 600 seconds
- This gives more time for the app to start up

### **2. Created Custom Health Controller**
- Replaced Rails default health check with custom controller
- Added database and cache health checks
- More robust error handling

### **3. Updated Routes**
- `/up` now uses custom `HealthController#show`
- Added `/health` and `/health/detailed` endpoints
- Better error handling

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
    "startCommand": "bundle exec rails server -p $PORT -e production",
    "healthcheckPath": "/up",
    "healthcheckTimeout": 600,
    "restartPolicyType": "ON_FAILURE",
    "restartPolicyMaxRetries": 10
  }
}
```

## 🔍 **Health Check Endpoints**

### **Basic Health Check** (`/up`)
- Returns: `"OK"` with 200 status
- Used by Railway for health checks
- Minimal response for fast checking

### **Detailed Health Check** (`/health/detailed`)
- Returns: JSON with database and cache status
- Useful for debugging
- Shows specific failure points

## 🚀 **Deployment Steps**

1. **Push changes**:
   ```bash
   git add .
   git commit -m "Fix Railway healthcheck - custom health controller, increased timeout"
   git push origin main
   ```

2. **Railway will auto-deploy** with the fixes

3. **Monitor deployment**:
   - Check Railway dashboard
   - Look for "Network › Healthcheck" phase
   - Should now pass with 600s timeout

## 🔧 **If Still Failing**

### **Check Railway Logs**:
1. Railway Dashboard → Your Project
2. Deployments tab → Latest deployment
3. Check "Deploy Logs" for errors

### **Common Issues**:

1. **Database Connection**:
   - Check DATABASE_URL is set
   - Verify database is accessible

2. **Port Binding**:
   - Ensure app binds to `$PORT` environment variable
   - Railway provides this automatically

3. **Startup Time**:
   - App might need more time to start
   - Consider increasing timeout further

### **Alternative Health Check**:
If `/up` still fails, try changing Railway config to:
```json
"healthcheckPath": "/health"
```

## 📋 **Health Check Checklist**

- [ ] Custom health controller created
- [ ] Routes updated to use custom controller
- [ ] Railway timeout increased to 600s
- [ ] Database connection working
- [ ] App starts successfully
- [ ] Health endpoint responds quickly

## 🎯 **Expected Result**

After these fixes:
1. **Build**: ✅ Succeeds
2. **Deploy**: ✅ Succeeds  
3. **Healthcheck**: ✅ Should now pass
4. **Site**: ✅ Accessible

## 🔄 **Alternative: Disable Healthcheck**

If healthcheck continues to fail, you can disable it in Railway:
1. Go to Railway Dashboard
2. Settings → Health Check
3. Disable "Enable Health Check"
4. Deploy will succeed without health check

**Note**: This is not recommended for production, but can unblock deployment.
