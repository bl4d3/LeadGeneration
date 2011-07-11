class CreateQueuedEmails < ActiveRecord::Migration
  def self.up
    create_table :queued_emails do |t|
      t.string :mailer
      t.string :mailer_method
      t.text :args
      t.integer :priority, :default => 0

      t.timestamps
    end
  end

  def self.down
    drop_table :queued_emails
  end
end
