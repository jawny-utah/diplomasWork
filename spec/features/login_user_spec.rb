require "rails_helper"

describe "Login user", js: true do
  it "success" do
    visit("/")
    User.create(email: "slideboom671@gmail.com", full_name: "Шевченко Дмитро",
                phone_number: "380963774232", password: "123123", password_confirmation: "123123")
    click_link "Увійти"
    within "form[action='/users/login']" do
      fill_in "email", with: "slideboom671@gmail.com"
      fill_in "password", with: "123123"
      click_on "Увійти"
    end
    expect(page).to have_content("Ви успішно увійшли")
    expect(page).to have_content("Шевченко Дмитро")
  end

  it "failure" do
    visit("/")
    click_link "Увійти"
    within "form[action='/users/login']" do
      fill_in "email", with: "slideboom671@gmail.com"
      fill_in "password", with: "123123"
      click_on "Увійти"
    end
    expect(page).to have_content("Неправильна пошта або пароль.")
    User.create(email: "slideboom671@gmail.com", full_name: "Шевченко Дмитро",
                phone_number: "380963774232", password: "123123", password_confirmation: "123123")
    within "form[action='/users/login']" do
      fill_in "email", with: "slideboom671@gmail.com"
      fill_in "password", with: "123123"
      click_on "Увійти"
    end
    expect(page).to have_content("Ви успішно увійшли")
    expect(page).to have_content("Шевченко Дмитро")
  end
end
