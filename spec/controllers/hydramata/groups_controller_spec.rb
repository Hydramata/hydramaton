require 'spec_helper'

describe Hydramata::GroupsController do
  before(:each) do
    described_class.runner_container = MockContainer.new(runner)
    runner.stub(:run).and_yield(callback)
  end

  let(:runner) { double('Runner', run: true) }
  let(:callback) { double('Callback', success: true, failure: true) }
  let(:valid_attributes) { { "name" => "MyString" } }
  let(:invalid_attributes) { { "name" => "" } }
  let(:group) { mock_model(Hydramata::Group, to_param: '1234') }
  let(:invalid_group) {  mock_model(Hydramata::Group, valid?: false, errors: ['there are errors']) }

  let(:valid_session) { {} }
  let(:message) { 'A Message' }

  describe "GET index" do
    it "assigns all hydramata_groups as @hydramata_groups" do
      callback.should_receive(:success).and_yield([group])

      get :index, {}, valid_session

      assigns(:hydramata_groups).should eq([group])
    end
  end

  describe "GET show" do
    it "assigns the requested hydramata_group as @hydramata_group" do
      callback.should_receive(:success).and_yield(group)

      get :show, {:id => group.to_param}, valid_session

      assigns(:hydramata_group).should eq(group)
      expect(runner).to have_received(:run).with(controller, group.to_param)
    end
  end

  describe "GET new" do
    it "assigns a new hydramata_group as @hydramata_group" do
      callback.should_receive(:success).and_yield(group)

      get :new, {hydramata_group: valid_attributes}, valid_session

      expect(assigns(:hydramata_group)).to eq(group)
      expect(runner).to have_received(:run).with(controller, valid_attributes)
    end
  end

  describe "GET edit" do
    it "assigns the requested hydramata_group as @hydramata_group" do
      callback.should_receive(:success).and_yield(group)

      get :edit, {id: group.to_param, hydramata_group: valid_attributes}, valid_session

      expect(assigns(:hydramata_group)).to eq(group)
      expect(runner).to have_received(:run).with(controller, group.to_param, valid_attributes)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      let(:group) { FactoryGirl.build_stubbed(:hydramata_group) }
      it "creates a new Hydramata::Group" do
        callback.should_receive(:success).and_yield(group, message)

        post :create, {:hydramata_group => valid_attributes}, valid_session

        response.should redirect_to(group)
        expect(runner).to have_received(:run).with(controller, valid_attributes)
      end
    end

    describe "with invalid params" do
      let(:group) { mock_model(Hydramata::Group, valid?: false, errors: ['there are errors']) }
      it "assigns a newly created but unsaved hydramata_group as @hydramata_group" do
        callback.should_receive(:failure).and_yield(group)

        post :create, {:hydramata_group => invalid_attributes}, valid_session

        expect(assigns(:hydramata_group)).to eq(group)
        expect(runner).to have_received(:run).with(controller, invalid_attributes)
        response.should render_template("new")
      end

    end
  end

  describe "PUT update" do
    describe "with valid params" do
      let(:group) { FactoryGirl.build_stubbed(:hydramata_group) }
      it "updates the requested hydramata_group" do
        callback.should_receive(:success).and_yield(group, message)

        put :update, {:id => group.to_param, :hydramata_group => valid_attributes }, valid_session

        expect(assigns(:hydramata_group)).to eq(group)
        expect(runner).to have_received(:run).with(controller, group.to_param, valid_attributes)
        response.should redirect_to(group)
      end
    end

    describe "with invalid params" do
      let(:group) { invalid_group }
      it "assigns the hydramata_group as @hydramata_group" do
        callback.should_receive(:failure).and_yield(group)

        put :update, {:id => group.to_param, :hydramata_group => invalid_attributes }, valid_session

        expect(assigns(:hydramata_group)).to eq(group)
        expect(runner).to have_received(:run).with(controller, group.to_param, invalid_attributes)
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested hydramata_group" do
      group.stub(:persisted?).and_return(false) # It got deleted.
      callback.should_receive(:success).and_yield(group)

      delete :destroy, {:id => group.to_param}, valid_session

      response.should redirect_to(hydramata_groups_url)
    end
  end

  class MockContainer

    def initialize(runner)
      @runner = runner
    end

    def const_defined?(*args)
      true
    end

    def const_get(*args)
      @runner
    end

  end

end
