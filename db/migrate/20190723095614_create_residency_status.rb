class CreateResidencyStatus < ActiveRecord::Migration[5.2]
  def change
    create_table :residency_statuses do |t|
      t.string :explanation
    end
  end
end
