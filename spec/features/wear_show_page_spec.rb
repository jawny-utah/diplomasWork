require "rails_helper"

describe "Wear show page", js: true do
  it "add default sizes to cart" do
    visit_wears_page_and_add_to_cart
    8.times do
      first("a[data-turbo-method='delete']", visible: true).click
      sleep 1
    end
    expect(page).to have_content("Ваша корзина порожня")
    visit_wears_page_and_add_to_cart
  end

  it "add wear two times while loggined in" do
    User.create(email: "slideboom671@gmail.com", full_name: "Шевченко Дмитро",
                phone_number: "380963774232", password: "123123", password_confirmation: "123123")
    visit("/")
    click_link "Увійти"
    within "form[action='/users/login']" do
      fill_in "email", with: "slideboom671@gmail.com"
      fill_in "password", with: "123123"
      click_on "Увійти"
    end
    expect(page).to have_content("Ви успішно увійшли")
    expect(page).to have_content("Шевченко Дмитро")
    visit("/wears/1")
    within "#default-sizes" do
      fill_in "order_wear_orders_attributes_0_wear_order_detail_sizes_attributes_1_quantity", with: ""
      fill_in "order_wear_orders_attributes_0_wear_order_detail_sizes_attributes_1_quantity", with: "4"
      click_on "Купити"
    end
    click_on "Повернутись"
    within "#default-sizes" do
      fill_in "order_wear_orders_attributes_0_wear_order_detail_sizes_attributes_1_quantity", with: ""
      fill_in "order_wear_orders_attributes_0_wear_order_detail_sizes_attributes_1_quantity", with: "4"
      click_on "Купити"
    end
    expect(page).to have_content("Оформити замовлення")
  end

  it "add custom sizes to cart" do
    visit("/wears/1")
    within("#custom-sizes") do
      first(".default-input").set("0")
      all(".default-input")[1..(all(".default-input").count)].each do |input|
        input.set("20")
      end
      click_on "Купити"
    end
    expect(page).to have_content("Ваша корзина порожня")
    find("body").send_keys(:escape)
    within("#custom-sizes") do
      all(".default-input").each do |input|
        input.set("20")
      end
      all(".default-input")[1].set("0")
      click_on "Купити"
    end
    expect(page).to have_content("Ваша корзина порожня")
    find("body").send_keys(:escape)
    within("#custom-sizes") do
      all(".default-input").each do |input|
        input.set("20")
      end
      all(".default-input")[3].set("0")
      click_on "Купити"
    end
    expect(page).to have_content("Ваша корзина порожня")
    find("body").send_keys(:escape)
    within("#custom-sizes") do
      all(".default-input").each do |input|
        input.set("20")
      end
      click_on "Купити"
    end
    expect(page).to have_content("Загальна кількість товарів: 20")
    click_on "Оформити замовлення"
    expect(page).to have_content("Оформлення замовлення")
  end
end

def visit_wears_page_and_add_to_cart
  visit("/wears/1")
  expect(page).to have_content(Wear.first.full_name)
  add_default_size_wears_to_cart
  expect(page).to have_content("Загальна кількість товарів: 20")
  expect(page).to have_content("Оформити замовлення")
  click_on "Повернутись"

  visit("/wears/2")
  expect(page).to have_content(Wear.second.full_name)
  add_default_size_wears_to_cart
  expect(page).to have_content("Загальна кількість товарів: 40")
  expect(page).to have_content("Оформити замовлення")
  click_on "Оформити замовлення"
  expect(page).to have_content("Оформлення замовлення")
end

def add_default_size_wears_to_cart
  within "#default-sizes" do
    find("input[name='order[wear_orders_attributes][0][wear_order_detail_sizes_attributes][0][classic_size]']").click
    expect(find("input[name='order[wear_orders_attributes][0][wear_order_detail_sizes_attributes][0][quantity]']").value).to eq("1")
    find("input[name='order[wear_orders_attributes][0][wear_order_detail_sizes_attributes][0][classic_size]']").click
    expect(find("input[name='order[wear_orders_attributes][0][wear_order_detail_sizes_attributes][0][quantity]']").value).to eq("0")
    fill_in "order_wear_orders_attributes_0_wear_order_detail_sizes_attributes_0_quantity", with: ""
    fill_in "order_wear_orders_attributes_0_wear_order_detail_sizes_attributes_0_quantity", with: "8"
    fill_in "order_wear_orders_attributes_0_wear_order_detail_sizes_attributes_1_quantity", with: ""
    fill_in "order_wear_orders_attributes_0_wear_order_detail_sizes_attributes_1_quantity", with: "4"
    fill_in "order_wear_orders_attributes_0_wear_order_detail_sizes_attributes_2_quantity", with: ""
    fill_in "order_wear_orders_attributes_0_wear_order_detail_sizes_attributes_2_quantity", with: "3"
    fill_in "order_wear_orders_attributes_0_wear_order_detail_sizes_attributes_3_quantity", with: ""
    fill_in "order_wear_orders_attributes_0_wear_order_detail_sizes_attributes_3_quantity", with: "5"
    click_on "Купити"
  end
end
