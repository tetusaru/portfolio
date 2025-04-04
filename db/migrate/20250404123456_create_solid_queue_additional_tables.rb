class CreateSolidQueueAdditionalTables < ActiveRecord::Migration[7.0]
  def change
    create_table :solid_queue_processes do |t|
      t.string :hostname, null: false
      t.string :name, null: false
      t.datetime :last_heartbeat_at, null: false
      t.datetime :started_at, null: false
      t.timestamps null: false
    end

    create_table :solid_queue_supervisors do |t|
      t.references :process, null: false, foreign_key: { to_table: :solid_queue_processes }
      t.string :name, null: false
      t.timestamps null: false
    end

    create_table :solid_queue_workers do |t|
      t.references :process, null: false, foreign_key: { to_table: :solid_queue_processes }
      t.string :queue_name, null: false
      t.string :name, null: false
      t.datetime :last_polled_at
      t.timestamps null: false
    end
  end
end
