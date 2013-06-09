require 'spec_helper'

describe "sessions" do
  context "logging in" do
    before do
      @user = User.create(name: "Erin", email: "e.b.drummond@gmail.com", password: "yes")
      visit login_path
    end

    it "has boxes for entering email and password" do
      expect(page).to have_content("Email")
      expect(page).to have_content("Password")
    end

    context "with invalid information" do
      it "throws an error when the email is blank" do
        fill_in("Password", with: "yes")
        click_button("Log in")
        expect(page).to have_content("Ah ah ah, you didn't say the magic word.")
      end

      it "throws an error when the password is blank" do
        fill_in("Email", with: "e.b.drummond@gmail.com")
        click_button("Log in")
        expect(page).to have_content("Ah ah ah, you didn't say the magic word.")
      end

      it "throws an error when the password is wrong" do
        fill_in("Email", with: "e.b.drummond@gmail.com")
        fill_in("Password", with: "no")
        click_button("Log in")
        expect(page).to have_content("Ah ah ah, you didn't say the magic word.")
      end
    end

    context "with valid information" do
      it "logs me in" do
        fill_in("Email", with: "e.b.drummond@gmail.com")
        fill_in("Password", with: "yes")
        click_button("Log in")
        expect(page).to have_content("Welcome back, Erin!")
      end
    end
  end
end