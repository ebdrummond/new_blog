require 'spec_helper'

describe 'the user edit page' do
  context "when logged in" do
    before do
      @user = User.create(name: "Erin", email: "e.b.drummond@gmail.com", password: "yes")
      visit login_path
      fill_in("Email", with: "e.b.drummond@gmail.com")
      fill_in("Password", with: "yes")
      click_button("Log in")
      visit edit_user_path(@user)
    end

    it "displays boxes to edit the name, email, and password" do
      expect(page).to have_content("Name")
      expect(page).to have_content("Email")
      expect(page).to have_content("Password")
    end

    context "with valid information" do
      it "updates the information" do
        fill_in("Name", with: "eebee")
        fill_in("Email", with: "eebee@sample.com")
        fill_in("Password", with: "yeah")
        fill_in("Password confirmation", with: "yeah")
        click_button("Update User")
        expect(page).to have_content("Your information has been updated.")
      end
    end

    context "with invalid information" do
      it "does not update the information" do
        fill_in("Name", with: "eebee")
        fill_in("Email", with: nil)
        fill_in("Password", with: "yeah")
        fill_in("Password confirmation", with: "yeah")
        click_button("Update User")
        expect(page).to have_content("Oh noes!")
        expect(page).to have_content("Email can't be blank")
      end
    end
  end

  context "when not logged in" do
    it "does not let me view the page" do
      visit edit_user_path(1)
      expect(page).to have_content("Whoopsidoodles!")
    end
  end
end