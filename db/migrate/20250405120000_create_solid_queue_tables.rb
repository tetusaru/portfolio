class CreateSolidQueueTables < ActiveRecord::Migration[7.1]
  def change
    create_table :solid_queue_processes do |t|
      t.string :name
      t.string :kind
      t.timestamps
    end

    create_table :solid_queue_threads do |t|
      t.references :process, null: false, foreign_key: { to_table: :solid_queue_processes }
      t.string :name
      t.timestamps
    end

    create_table :solid_queue_jobs do |t|
      t.string :queue_name, null: false
      t.string :job_class, null: false
      t.datetime :scheduled_at
      t.jsonb :arguments, default: []
      t.timestamps
    end

    create_table :solid_queue_assignments do |t|
      t.references :job, null: false, foreign_key: { to_table: :solid_queue_jobs }
      t.references :thread, null: false, foreign_key: { to_table: :solid_queue_threads }
      t.timestamps
    end
  end
end