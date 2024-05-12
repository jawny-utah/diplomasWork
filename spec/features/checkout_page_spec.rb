require "rails_helper"

describe "Checkout page", js: true do
  it "success" do
    visit("/wears/1")
    expect(page).to have_content(Wear.first.full_name)
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
    expect(page).to have_content("Загальна кількість товарів: 20")
    expect(page).to have_content("Оформити замовлення")
    click_on "Оформити замовлення"
    expect(page).to have_content("Оформлення замовлення")
    fill_in "order_shipment_order_attributes_customer_name", with: "Шевченко Дмитро"
    fill_in "order_shipment_order_attributes_customer_phone", with: "380963774232"
    fill_in "order_shipment_order_attributes_customer_email", with: "slideboom671@gmail.com"
    find(".ss-main").click
    find(".ss-option", text: "Київ").click
    sleep 2
    find("#order_shipment_order_attributes_shipment_type_nova_poshta_post_office").click
    find("#order_payment_type_post_office_payment").click
    click_on "Підтвердити замовлення"
    expect(page).to have_content("Ваше замовлення успішно приняте")
    visit("/")
    click_on "Шевченко Дмитро"
    expect(page).to have_content(Order.last.id)
    expect(page).to have_content("Ваші замовлення")
    expect(page).to have_content("Створений")
  end

  it "when user with entered data already registered but not loggined in" do
    visit("/wears/1")
    expect(page).to have_content(Wear.first.full_name)
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
    expect(page).to have_content("Загальна кількість товарів: 20")
    expect(page).to have_content("Оформити замовлення")
    click_on "Оформити замовлення"
    expect(page).to have_content("Оформлення замовлення")
    fill_in "order_shipment_order_attributes_customer_name", with: "Шевченко Дмитро"
    fill_in "order_shipment_order_attributes_customer_phone", with: "380963774232"
    fill_in "order_shipment_order_attributes_customer_email", with: "slideboom671@gmail.com"
    find(".ss-main").click
    find(".ss-option", text: "Київ").click
    sleep 2
    find("#order_shipment_order_attributes_shipment_type_nova_poshta_post_office").click
    find("#order_payment_type_post_office_payment").click
    User.create(email: "slideboom671@gmail.com", full_name: "Шевченко Дмитро",
                phone_number: "380963774232", password: "123123", password_confirmation: "123123")
    click_on "Підтвердити замовлення"
    expect(page).to have_content("Користувач з введеним email вже зареєстрований, будь ласка, увійдіть в аккаунт.")
    expect(page).to have_content("Користувач з введеним телефоном вже зареєстрований, будь ласка, увійдіть в аккаунт.")
    fill_in "order_shipment_order_attributes_customer_phone", with: "380963774234"
    fill_in "order_shipment_order_attributes_customer_email", with: "slideboom672@gmail.com"
    click_on "Підтвердити замовлення"
    expect(page).to have_content("Ваше замовлення успішно приняте")
    visit("/")
    click_on "Шевченко Дмитро"
    expect(page).to have_content(Order.last.id)
    expect(page).to have_content("Ваші замовлення")
    expect(page).to have_content("Створений")
  end
end
