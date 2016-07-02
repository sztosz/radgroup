class CreateRadCheckGroups < ActiveRecord::Migration[5.0]
  def change
    create_table :rad_check_groups do |t|
      t.string :groupname
      t.string :attr
      t.string :op
      t.string :value
    end
  end
end
