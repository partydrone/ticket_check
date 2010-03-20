class CreateTickets < ActiveRecord::Migration
  def self.up
    create_table :tickets do |t|
      t.integer :order_id, :count
      t.timestamps
    end
    add_index :tickets, :order_id, :unique => true
  end

  def self.down
    remove_index :tickets, :order_id
    drop_table :tickets
  end
end
