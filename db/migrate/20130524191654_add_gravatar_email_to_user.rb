class AddGravatarEmailToUser < ActiveRecord::Migration
  def change
    add_column :users, :gravatar_email, :string, limit: 255
  end
end
