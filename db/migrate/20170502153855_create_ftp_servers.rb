class CreateFtpServers < ActiveRecord::Migration[5.0]
  def change
    create_table :ftp_servers do |t|
      t.references :brand, foreign_key: true
      t.string :url
      t.integer :port
      t.string :username
      t.string :password

      t.timestamps
    end
  end
end
