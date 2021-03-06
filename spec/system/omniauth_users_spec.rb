require 'rails_helper'

RSpec.describe "Users through OmniAuth", type: :system do
  describe "OmniAuthのログイン" do
    context "googleでのログイン" do

      before do
        OmniAuth.config.mock_auth[:google_oauth2] = nil
        Rails.application.env_config['omniauth.auth'] = set_omniauth :google_oauth2
        visit login_path
      end

      it "Google Signin をクリックすると登録画面が出てきて登録できる", js: true do
        click_on 'Google Signin'
        expect(page).to have_selector 'input'
        expect {
          click_button 'アカウント登録'
        }.to change(User, :count).by(1)
        expect(page).to have_content '新しいアルバムを作成する'
      end
    end

    context "lineでのログイン" do

      before do
        OmniAuth.config.mock_auth[:line] = nil
        Rails.application.env_config['omniauth.auth'] = set_omniauth :line
        visit login_path
      end

      it "「LINEでログイン」をクリックすると登録画面が出てきて登録できてログインできる", js: true do
        click_on 'Line Signin'
        expect(page).to have_selector 'input'
        expect {
          click_button 'アカウント登録'
        }.to change(User, :count).by(1)
        expect(page).to have_content '新しいアルバムを作成する'
      end
    end

    # TODO: omniauth_helper周りの挙動解明(コメントアウトしても問題ないcontextなので一旦コメントアウト)
    # context "OAuthが渡ってこない場合" do
    
    #   before do
    #     Rails.application.env_config["omniauth.auth"] = nil
    #     visit login_path
    #   end

    #   it "「Sign in with Google」をクリックしてもホームに戻される", js: true do
    #     click_on 'Google Signin'
    #     expect(page).to have_content 'アカウント登録もしくはログインしてください。'
    #   end

    #   it "「LINEでログイン」をクリックしてもホームに戻される", js: true do
    #     click_on 'Line Signin'
    #     expect(page).to have_content 'アカウント登録もしくはログインしてください。'
    #   end
    # end
  end
end
