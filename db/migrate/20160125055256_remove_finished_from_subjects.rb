class RemoveFinishedFromSubjects < ActiveRecord::Migration
  def change
    remove_column :subjects, :finished, :boolean
  end
end
