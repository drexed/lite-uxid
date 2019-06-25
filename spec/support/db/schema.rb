# frozen_string_literal: true

ActiveRecord::Schema.define(version: 1) do
  create_table :users, force: :cascade do |t|
    t.binary :uxid, index: { unique: true }
    t.string :name
    t.timestamps null: false
  end
end
