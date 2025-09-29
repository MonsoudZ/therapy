# Admin Panel Guide

## 🔐 Admin Login

**URL:** `/admins/sign_in`  
**Email:** `admin@angelakeeley.com`  
**Password:** `password123`

## 📋 Admin Features

### 1. **Dashboard** (`/admin`)
- Overview of contact requests and site content
- Quick statistics
- Recent activity

### 2. **Site Content Management** (`/admin/site_contents`)
- **Add new content** - Create editable text blocks
- **Edit existing content** - Update titles, descriptions, etc.
- **Delete content** - Remove outdated content

#### Content Types:
- **Text** - Plain text content
- **HTML** - Rich HTML content (supports formatting)
- **Markdown** - Markdown formatted content

### 3. **Contact Requests** (`/admin/contact_requests`)
- **View all requests** - See all incoming contact forms
- **View details** - Full contact information and messages
- **Delete requests** - Clean up old requests

## 🎯 How to Use

### Adding New Content:
1. Go to **Site Content** → **Add New Content**
2. Fill in:
   - **Key**: Unique identifier (e.g., `services_intro`, `footer_text`)
   - **Title**: Display name for admin reference
   - **Content**: The actual text/HTML content
   - **Type**: Choose Text, HTML, or Markdown
3. Click **Create Content**

### Editing Content:
1. Go to **Site Content** → Click **Edit** next to any item
2. Make your changes
3. Click **Update Content**

### Managing Contact Requests:
1. Go to **Contact Requests** to see all incoming messages
2. Click **View** to see full details
3. Use **Delete** to remove old requests

## 🔧 Technical Details

### Content Keys Currently Used:
- `hero_title` - Main page headline
- `hero_subtitle` - Main page description  
- `about_intro` - About page introduction
- `about_approach` - About page approach section
- `contact_intro` - Contact page description

### Adding Content to Views:
In your view files, use:
```erb
<%= site_content('your_key', 'default fallback text') %>
```

## 🚀 Next Steps

1. **Change the admin password** immediately
2. **Add your own content** using the admin panel
3. **Customize the content keys** as needed
4. **Add more content types** as your site grows

## 🔒 Security

- Admin panel is password protected
- Only authenticated admins can access
- All admin actions are logged
- Change default password before going live
