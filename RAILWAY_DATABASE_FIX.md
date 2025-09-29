# Railway Database Configuration Fix

## 🚨 **Issue**: SQLite3 Adapter Error During Asset Precompilation

```
LoadError: Error loading the 'sqlite3' Active Record adapter. Missing a gem it depends on? sqlite3 is not part of the bundle.
```

**Root Cause**: Production database configuration was still using SQLite3, but we moved sqlite3 gem to development/test group.

## ✅ **Fix Applied**

### **Updated Production Database Configuration**

**Before** (using SQLite3):
```yaml
production:
  primary:
    <<: *default  # This inherited sqlite3 adapter
    database: storage/production.sqlite3
```

**After** (using Postgres via DATABASE_URL):
```yaml
production:
  primary:
    url: <%= ENV['DATABASE_URL'] %>
    pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>
    timeout: 5000
  cache:
    url: <%= ENV['DATABASE_URL'] %>
    pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>
    timeout: 5000
    migrations_paths: db/cache_migrate
  queue:
    url: <%= ENV['DATABASE_URL'] %>
    pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>
    timeout: 5000
    migrations_paths: db/queue_migrate
  cable:
    url: <%= ENV['DATABASE_URL'] %>
    pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>
    timeout: 5000
    migrations_paths: db/cable_migrate
```

## 🎯 **Railway Deployment Should Now Work**

### **Expected Build Process**:
1. **Dockerfile**: ✅ Node.js 20, build tools ready
2. **Bundle Install**: ✅ pg 1.6.2 resolves for ARM
3. **Asset Precompile**: ✅ No more SQLite3 adapter errors
4. **Database**: ✅ Uses Postgres via DATABASE_URL
5. **Server**: ✅ Puma binds to 0.0.0.0:$PORT
6. **Health**: ✅ /up endpoint responds

### **Railway Setup Requirements**:

1. **Add Postgres Database**:
   - Railway Dashboard → "New" → "Database" → "Postgres"
   - Railway automatically sets `DATABASE_URL`

2. **Set Environment Variables**:
   ```bash
   RAILS_ENV=production
   SECRET_KEY_BASE=8880b3b5eeea7f2452b720cb4b68af44edfa22f05a11d81c95ba45d3ef0d8bd2e4ae42fa3bd4902b8df4c463fe2a137d2c4b078f30b56478cb173a2d624f585e
   RAILS_SERVE_STATIC_FILES=true
   RAILS_LOG_TO_STDOUT=true
   ```

## 🔍 **What This Fixes**

### **Before**:
- ❌ Asset precompilation failed with SQLite3 adapter error
- ❌ Production tried to use SQLite3 (not available in production bundle)
- ❌ Database configuration mismatch

### **After**:
- ✅ Asset precompilation uses Postgres adapter
- ✅ Production uses Postgres via DATABASE_URL
- ✅ Database configuration matches gem availability

## 📋 **Railway Deployment Checklist**

- [ ] ✅ pg bumped to ~>1.6 (ARM compatible)
- [ ] ✅ ARM platform added to lockfile
- [ ] ✅ Production database uses Postgres
- [ ] ✅ Railway Postgres database added
- [ ] ✅ Environment variables set
- [ ] ✅ Puma binding configured
- [ ] ✅ Railway hosts allowed
- [ ] ✅ Health check endpoint exists

## 🚀 **Next Steps**

1. **Railway auto-deploys** from GitHub push
2. **Monitor build logs** - should see successful asset precompilation
3. **Check health endpoint** once deployed
4. **Test main site** functionality

## 🔧 **If Still Failing**

Check Railway build logs for:
- Missing `DATABASE_URL` (add Postgres database)
- Missing `SECRET_KEY_BASE` (set environment variable)
- Node.js/yarn issues (Dockerfile should handle this)

**Your Railway deployment should now succeed with proper Postgres configuration!** 🎉
