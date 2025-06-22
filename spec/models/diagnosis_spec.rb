require 'rails_helper'

RSpec.describe Diagnosis, type: :model do
  describe 'アソシエーション' do
    it { should belong_to(:user).optional }
    it { should have_many(:answers).dependent(:destroy).inverse_of(:diagnosis) }
    it { should have_many(:diagnosis_results).dependent(:destroy) }
    it { should have_many(:diagnosis_recommendations).dependent(:destroy) }
  end

  describe 'ネスト属性' do
    it 'answers のネスト属性を許可している' do
      expect(Diagnosis.nested_attributes_options.keys).to include(:answers)
    end
  end

  describe 'バリデーションなしで保存できるか' do
    it 'userがいなくても保存できる' do
      diagnosis = Diagnosis.new
      expect(diagnosis.save).to be_truthy
    end
  end
end
