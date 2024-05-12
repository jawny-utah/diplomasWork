require "rails_helper"

describe "Register user", js: true do
  it "success" do
    visit("/")
    click_link "Увійти"
    within "form[action='/users']" do
      fill_in "user_email", with: "slideboom671@gmail.com"
      fill_in "user_full_name", with: "Шевченко Дмитро"
      fill_in "user_phone_number", with: "380963774232"
      fill_in "user_password", with: "123123"
      fill_in "user_password_confirmation", with: "123123"
      click_on "Створити"
    end
    expect(page).to have_content("Користувач був успішно створений")
    expect(page).to have_content("Шевченко Дмитро")
  end

  describe "failure" do
    it "failing register form" do
      visit("/")
      click_link "Увійти"
      within "form[action='/users']" do
        fill_in "user_email", with: "slideboom671@gmail.com"
        fill_in "user_full_name", with: "Шевченко Дмитро"
        fill_in "user_phone_number", with: "380963774232"
        fill_in "user_password", with: "123"
        fill_in "user_password_confirmation", with: "123"
        click_on "Створити"
      end
      expect(page).to have_content("Пароль занадто короткий (мінімум 6 знаку)")
      expect(page).to have_content("Увійти")
      within "form[action='/users']" do
        fill_in "user_password", with: "123456"
        fill_in "user_password_confirmation", with: "123"
        click_on "Створити"
      end
      expect(page).to have_content("Пароль не збігається з підтвердженням")
      within "form[action='/users']" do
        fill_in "user_password", with: "123456"
        fill_in "user_password_confirmation", with: "123456"
        fill_in "user_phone_number", with: "3809637742"
        click_on "Створити"
      end
      expect(page).to have_content("Номер телефону недійсний")
      within "form[action='/users']" do
        fill_in "user_phone_number", with: "380963774232"
        fill_in "user_email", with: "slideboom671"
        click_on "Створити"
      end
      expect(page).to have_content("Email недійсний")
    end

    it "uniq fields validation" do
      visit("/")
      click_link "Увійти"
      within "form[action='/users']" do
        fill_in "user_email", with: "slideboom671@gmail.com"
        fill_in "user_full_name", with: "Шевченко Дмитро"
        fill_in "user_phone_number", with: "380963774232"
        fill_in "user_password", with: "123123"
        fill_in "user_password_confirmation", with: "123123"
        click_on "Створити"
      end
      expect(page).to have_content("Користувач був успішно створений")
      expect(page).to have_content("Шевченко Дмитро")
      click_on "Шевченко Дмитро"
      click_on "Вийти"
      click_link "Увійти"
      within "form[action='/users']" do
        fill_in "user_email", with: "slideboom671@gmail.com"
        fill_in "user_full_name", with: "Шевченко Дмитро"
        fill_in "user_phone_number", with: "380963774232"
        fill_in "user_password", with: "123123"
        fill_in "user_password_confirmation", with: "123123"
        click_on "Створити"
      end
      expect(page).to have_content("Email вже зайнятий")
      expect(page).to have_content("Номер телефону вже зайнятий")
    end
  end
end
