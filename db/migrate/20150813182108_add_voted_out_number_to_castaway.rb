class AddVotedOutNumberToCastaway < ActiveRecord::Migration
  def change
    add_column :castaways, :voted_out_number, :integer
  end
end
