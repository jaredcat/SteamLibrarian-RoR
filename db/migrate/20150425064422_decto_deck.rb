class DectoDeck < ActiveRecord::Migration
  def change
    change_table :games do |t|
      t.rename :dec, :deck
    end
  end
end
