class CreateMetrics < ActiveRecord::Migration[7.0]
  def change
    create_table :metrics do |t|
      t.string :name, null: false, limit: 250
      t.decimal :value, precision: 15, scale: 2, null: false
      t.uuid :uid, null: false, index: { unique: true, name: 'unique_uid' }
      t.timestamps
    end
    add_index :metrics, %i[name created_at], name: 'by_name_and_date'
  end
end
