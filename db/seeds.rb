# Create admin user
admin_email = ENV.fetch("ADMIN_EMAIL", "admin@columbinetherapy.com")
admin_password = ENV.fetch("ADMIN_PASSWORD", "password123")

admin = Admin.find_or_create_by(email: admin_email) do |a|
  a.password = admin_password
  a.password_confirmation = admin_password
end

puts "Admin user created: #{admin.email}"
puts "Admin password: #{admin_password}"

# Create initial site content
site_contents = [
  {
    key: 'hero_title',
    title: 'Hero Section Title',
    content: 'Individual + <em class="text-[#416970]">Relationship</em> Therapy',
    content_type: 'html'
  },
  {
    key: 'hero_subtitle',
    title: 'Hero Section Subtitle',
    content: 'Counseling for individuals and couples who are ready to make <em>lasting and impactful change</em> in themselves, their lives and relationships.',
    content_type: 'html'
  },
  {
    key: 'about_intro',
    title: 'About Page Introduction',
    content: 'I\'m Angela Keeley, a therapist who specializes in helping people access more <em>safety, connection and pleasure</em> in their lives. My approach blends traditional and cutting-edge modalities to help clients navigate stuck patterns, relationships, and personal growth with more ease and authenticity.',
    content_type: 'html'
  },
  {
    key: 'about_approach',
    title: 'About Page Approach',
    content: 'I specialize in working with folks who feel this way. I welcome all the things about you and your experiences that make you unique and brought you to where you are today. There are some parts you may be immensely proud of, and other things you may spend a lot of energy trying to hide. <em>I welcome all of you here.</em>',
    content_type: 'html'
  },
  {
    key: 'contact_intro',
    title: 'Contact Page Introduction',
    content: 'Please complete this form to schedule a free, 15-minute consultation.',
    content_type: 'text'
  }
]

site_contents.each do |content_data|
  content = SiteContent.find_or_create_by(key: content_data[:key]) do |sc|
    sc.title = content_data[:title]
    sc.content = content_data[:content]
    sc.content_type = content_data[:content_type]
  end
  puts "Site content created: #{content.key}"
end

puts "Seeding completed!"