require 'spec_helper'

describe Hydramata::GroupsController do

  let(:valid_attributes) { { "name" => "MyString" } }

  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all hydramata_groups as @hydramata_groups" do
      group = Hydramata::Group.create! valid_attributes
      get :index, {}, valid_session
      assigns(:hydramata_groups).should eq([group])
    end
  end

  describe "GET show" do
    it "assigns the requested hydramata_group as @hydramata_group" do
      group = Hydramata::Group.create! valid_attributes
      get :show, {:id => group.to_param}, valid_session
      assigns(:hydramata_group).should eq(group)
    end
  end

  describe "GET new" do
    it "assigns a new hydramata_group as @hydramata_group" do
      get :new, {}, valid_session
      assigns(:hydramata_group).group.should be_a_new(Hydramata::Group)
    end
  end

  describe "GET edit" do
    it "assigns the requested hydramata_group as @hydramata_group" do
      group = Hydramata::Group.create! valid_attributes
      get :edit, {:id => group.to_param}, valid_session
      assigns(:hydramata_group).group.should eq(group)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Hydramata::Group" do
        expect {
          post :create, {:hydramata_group => valid_attributes}, valid_session
        }.to change(Hydramata::Group, :count).by(1)
        response.should redirect_to(Hydramata::Group.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved hydramata_group as @hydramata_group" do
        post :create, {:hydramata_group => { "name" => nil }}, valid_session
        assigns(:hydramata_group).group.should be_a_new(Hydramata::Group)
        response.should render_template("new")
      end

    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested hydramata_group" do
        group = Hydramata::Group.create! valid_attributes
        put :update, {:id => group.to_param, :hydramata_group => { "name" => "MyString" }}, valid_session
        assigns(:hydramata_group).group.should eq(group)
        response.should redirect_to(group)
      end
    end

    describe "with invalid params" do
      it "assigns the hydramata_group as @hydramata_group" do
        group = Hydramata::Group.create! valid_attributes
        put :update, {:id => group.to_param, :hydramata_group => { "name" => "" }}, valid_session
        assigns(:hydramata_group).group.should eq(group)
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested hydramata_group" do
      group = Hydramata::Group.create! valid_attributes
      expect {
        delete :destroy, {:id => group.to_param}, valid_session
      }.to change(Hydramata::Group, :count).by(-1)
      response.should redirect_to(hydramata_groups_url)
    end
  end

end
