require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'バリデーション' do
    it '名前、メール、パスワードがあれば有効' do
      user = User.new(
        name: 'テスト太郎',
        email: 'test@example.com',
        password: 'secure123',
        password_confirmation: 'secure123'
      )
      expect(user).to be_valid
    end

    it '名前が空だと無効' do
      user = User.new(
        name: '',
        email: 'test@example.com',
        password: 'secure123',
        password_confirmation: 'secure123'
      )
      expect(user).to_not be_valid
      expect(user.errors[:name]).to include("を入力してください")
    end

    it 'メールが空だと無効' do
      user = User.new(
        name: 'テスト太郎',
        email: '',
        password: 'secure123',
        password_confirmation: 'secure123'
      )
      expect(user).to_not be_valid
      expect(user.errors[:email]).to include("を入力してください")
    end

    it 'メールが重複していると無効' do
      User.create!(
        name: '既存ユーザー',
        email: 'duplicate@example.com',
        password: 'password',
        password_confirmation: 'password'
      )

      user = User.new(
        name: '新しいユーザー',
        email: 'duplicate@example.com',
        password: 'password',
        password_confirmation: 'password'
      )
      expect(user).to_not be_valid
      expect(user.errors[:email]).to include("はすでに存在します")
    end

    it 'パスワードが3文字未満だと無効' do
      user = User.new(
        name: 'テスト太郎',
        email: 'test@example.com',
        password: 'aa',
        password_confirmation: 'aa'
      )
      expect(user).to_not be_valid
      expect(user.errors[:password]).to include("は3文字以上で入力してください")
    end

    it 'パスワード確認が一致しないと無効' do
      user = User.new(
        name: 'テスト太郎',
        email: 'test@example.com',
        password: 'secure123',
        password_confirmation: 'mismatch'
      )
      expect(user).to_not be_valid
      expect(user.errors[:password_confirmation]).to include("とパスワードの入力が一致しません")
    end
  end
end
