require 'rails_helper'

RSpec.feature "Cars", type: :feature do
  let!(:user) { create(:user) }
  let!(:car) { create(:car, user: user) }

  before do
    login_as(user, scope: :user)

    # sign_in user
  end

  scenario "User views a car" do
    visit car_path(car)
    expect(page).to have_content("Toyota")
    expect(page).to have_content(car.car_model)
  end

  scenario "User creates a new car" do
    visit new_car_path
    expect(page).to have_content("Add New Car Advert")

    fill_in "Brand", with: "Mercedes"
    fill_in "Car model", with: "Gle"
    fill_in "Mileage", with: "45"
    fill_in "Price", with: "20000"
    fill_in "Body", with: "sedan"
    fill_in "Color", with: "black"
    fill_in "Fuel", with: "gas"
    fill_in "Volume", with: "1.8"
    # attach_file("images[]", Rails.root.join("spec/fixtures/files/mercedes.webp"))
    click_button "Save"

    expect(page).to have_content("Car was successfully created.")
    expect(page).to have_content("Mercedes")
  end

  scenario "User updates a car" do
    visit edit_car_path(car)
    fill_in "Brand", with: "Honda"
    click_button "Save"

    expect(page).to have_content("Car was successfully updated.")
    expect(page).to have_content("Honda")
  end

  context "Admin features" do
    let!(:user) { create(:user, admin: true) }

    before do
      login_as(user, scope: :user)
    end

    scenario "Admin marks a car as approved" do
      visit edit_path(car)
      select 'approved', from: 'Status'
      click_button "Save"

      expect(page).to have_content("Car successfully updated")
      expect(car.reload.featured).to be_truthy
    end
  end
end
