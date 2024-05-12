require "rails_helper"

describe "Main page", js: true do
  it "no items filter" do
    visit("/")
    expect(page).to have_content("Всього товарів: 11")
    visit("/?subcategory=&brand%5B%5D=asdc")
    expect(page).to have_content("Всього товарів: 0")
    expect(page).to have_content("Не знайдено товарів за введеними фільтрами")
    click_on "Скинути фільтри"
    expect(page).to have_content("Всього товарів: 11")
  end
end
