class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.references :product, null: false, foreign_key: true
      t.decimal :amount
      t.string :status, default: 'initial'
      t.string :payment_token
      t.string :redirect_url

      t.timestamps
    end
  end
end
