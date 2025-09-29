# Domain Setup for columbinetherapy.com

## 🌐 **Railway Domain Configuration**

### **Step 1: Railway Default Domain**
- Railway provides: `https://your-app-name.railway.app`
- This works immediately after deployment
- Test your app here first

### **Step 2: Add Custom Domain in Railway**

1. **Go to Railway Dashboard**
   - Select your project
   - Go to **Settings** → **Domains**

2. **Add Custom Domain**
   - Click **"Add Domain"**
   - Enter: `columbinetherapy.com`
   - Railway will show DNS instructions

3. **Railway will give you DNS records like:**
   ```
   Type: CNAME
   Name: @
   Value: your-app.railway.app
   
   Type: CNAME  
   Name: www
   Value: your-app.railway.app
   ```

### **Step 3: Update Your DNS Provider**

Go to your domain registrar (where you bought columbinetherapy.com) and add:

```
Type: CNAME
Name: @
Value: your-app.railway.app

Type: CNAME
Name: www  
Value: your-app.railway.app
```

### **Step 4: Update Railway Environment Variables**

In Railway dashboard → Variables, add:
```bash
RAILS_HOST=columbinetherapy.com
```

### **Step 5: Wait for DNS Propagation**
- DNS changes take 5-60 minutes
- Check with: `nslookup columbinetherapy.com`

### **Step 6: Test Your Domain**
- Visit: `https://columbinetherapy.com`
- Should redirect to your Railway app
- SSL certificate will be automatic

## 🔧 **Domain Configuration in Rails**

The `RAILS_HOST` environment variable is used for:

```ruby
# In your Rails app
Rails.application.routes.default_url_options[:host] = ENV['RAILS_HOST']

# Email links
root_url  # Uses RAILS_HOST

# Admin panel links  
admin_root_url  # Uses RAILS_HOST

# Contact form redirects
contact_url  # Uses RAILS_HOST
```

## 🎯 **Complete Setup Checklist**

- [ ] Deploy to Railway (get default domain)
- [ ] Add custom domain in Railway settings
- [ ] Update DNS records at your registrar
- [ ] Set `RAILS_HOST=columbinetherapy.com` in Railway
- [ ] Wait for DNS propagation
- [ ] Test `https://columbinetherapy.com`

## 🚨 **Common Issues**

### **Domain not working?**
- Check DNS records are correct
- Wait for DNS propagation (up to 60 minutes)
- Verify domain is added in Railway

### **SSL not working?**
- Railway provides automatic SSL
- Wait 5-10 minutes after domain setup
- Check Railway dashboard for SSL status

### **App not loading?**
- Check Railway logs
- Verify environment variables
- Test default Railway domain first

## 💡 **Pro Tips**

1. **Test default domain first** - Make sure app works on `your-app.railway.app`
2. **Use www and non-www** - Set up both `columbinetherapy.com` and `www.columbinetherapy.com`
3. **Check SSL status** - Railway provides automatic SSL certificates
4. **Monitor logs** - Check Railway logs if domain isn't working
