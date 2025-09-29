class CreateContactRequests < ActiveRecord::Migration[8.0]
  def change
    create_table :contact_requests do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :phone
      t.string :state
      t.string :subject
      t.text :message
      t.string :referral

      t.timestamps
    end
  end
end
