require 'rails_helper'

RSpec.describe "Diagnoses", type: :request do
  let!(:facility) do
    SaunaFacility.create!(
      name: "サンプルサウナ",
      location: "東京都",
      temperature_level: "very_hot",
      facility_type: "sauna",
      atmosphere: "modern",
      outdoor_bath: true,
      cold_bath: true
    )
  end

  describe "GET /survey" do
    it "最初の質問にリダイレクトされる" do
      get "/survey"
      expect(response).to redirect_to("/survey?question_id=1")
    end

    it "質問IDを指定すると質問が表示される" do
      get "/survey", params: { question_id: 1 }
      expect(response).to have_http_status(:ok)
      expect(response.body).to include("お好みのサウナのアツさは？")
    end
  end

  describe "POST /survey/answer" do
    it "次の質問にリダイレクトされる" do
      post "/survey/answer", params: { question_id: 1, answer: "ゲキアツ" }
      expect(response).to redirect_to("/survey?question_id=2")
    end
  end

  describe "POST /survey/finish" do
    before do
      post "/survey/answer", params: { question_id: 1, answer: "ゲキアツ" }
      post "/survey/answer", params: { question_id: 2, answer: "はい" }
      post "/survey/answer", params: { question_id: 3, answer: "はい" }
      post "/survey/answer", params: { question_id: 4, answer: "サウナ施設" }
      post "/survey/answer", params: { question_id: 5, answer: "新しく綺麗" }
      post "/survey/answer", params: { question_id: 6, answer: "男性" }
    end

    it "診断結果にリダイレクトされる" do
      post "/survey/finish", params: {
        question_id: 7,
        answer: "東京"
      }

      expect(response).to redirect_to(diagnosis_path(id: facility.id))
    end

    it "診断結果が見つからない場合に no_result にリダイレクトされる" do
      # 条件に一致しない施設を追加しておく（東京以外）
      SaunaFacility.create!(
        name: "条件不一致サウナ",
        location: "北海道",
        temperature_level: "mild",
        facility_type: "super_sento",
        atmosphere: "classic",
        outdoor_bath: false,
        cold_bath: false
      )

      post "/survey/finish", params: {
        question_id: 7,
        answer: "存在しない地域"
      }

      expect(response).to redirect_to(diagnosis_path(id: 0, no_result: true))
    end
  end

  describe "GET /diagnoses/:id" do
    it "診断結果の施設情報が表示される" do
      get "/diagnoses/#{facility.id}"
      expect(response).to have_http_status(:ok)
      expect(response.body).to include("サンプルサウナ")
    end

    it "診断結果がないときにメッセージが表示される" do
      get "/diagnoses/0", params: { no_result: true }
      expect(response).to have_http_status(:ok)
      expect(response.body).to include("診断結果が見つかりませんでした")
    end
  end
end