require 'rails_helper'

RSpec.describe "Cars", type: :request do
  let(:user) { create(:user) }
  let(:car) { create(:car, user: user) }

  before do
    sign_in user
  end

  describe "GET /cars" do
    it "renders the index template" do
      get cars_path
      expect(response).to have_http_status(:ok)
      expect(response.body).to include("Cars")
    end

    it "renders the index template when user_id is present" do
      get cars_path(user_id: user.id)
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET /cars/:id" do
    it "renders the show template" do
      get car_path(car)
      expect(response).to have_http_status(:ok)
      expect(response.body).to include(car.brand)
    end
  end

  describe "GET /cars/new" do
    it "renders the new template" do
      get new_car_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST /cars" do
    it "creates a new car" do
      expect {
        post cars_path, params: { car: attributes_for(:car) }
      }.to change(Car, :count).by(1)
      expect(response).to redirect_to(car_path(Car.last))
    end
  end

  describe "GET /cars/:id/edit" do
    it "renders the edit template" do
      get edit_car_path(car)
      expect(response).to have_http_status(:ok)
    end
  end

  describe "PATCH/PUT /cars/:id" do
    it "updates the car" do
      patch car_path(car), params: { car: { brand: "New Brand" } }
      car.reload
      expect(car.brand).to eq("New Brand")
      expect(response).to redirect_to(car_path(car))
    end
  end

  describe "DELETE /cars/:id" do
    it "destroys the car" do
      car_to_delete = create(:car, user: user)
      expect {
        delete car_path(car_to_delete)
      }.to change(Car, :count).by(-1)
      expect(response).to redirect_to(cars_path)
    end
  end
end
