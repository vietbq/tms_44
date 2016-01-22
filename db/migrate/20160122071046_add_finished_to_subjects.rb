class AddFinishedToSubjects < ActiveRecord::Migration
  def change
    add_column :subjects, :finished, :boolean, default: false
  end
end
