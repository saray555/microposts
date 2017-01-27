class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest

      t.timestamps null: false 
      # 下記でユニークインデックスを追加して、メールアドレスが他と異なるようにしています。
      t.index :email, unique: true 
    end
  end
end
