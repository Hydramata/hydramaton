require 'spec_helper'

module Hydramata::Deposit
  describe WorksController do
    # @NOTE - There is a lot of knowledge of how the form object is built.
    #
    # Given that we are dynamically looking up what forms to use
    # It is, at present, hard to intercept the returned form object.
    # The goal of these stubs is to not worry about how the forms are created
    # but instead making sure the controller is behaving as expected:
    # * Does it trigger an authorization check
    # * Does it fetch the appropriate form
    # * Does it redirect on a successful save
    # * Does it render the 'new' action on a failed save
    let(:work_type) { 'foo' }
    let(:work_form_class) { Hydramata::FormFinalizer.call(work_type, work_form_configuration) }
    let(:pid) { '1234' }
    let(:work_form_configuration) {
      {
        fieldsets: { required: { attributes: { title: String }, validates: { title: {presence: true} } } },
        identity_minter: lambda {|*args| pid }
      }
    }
    context 'new/create' do
      let(:work_form) { work_form_class.new(controller) }

      before(:each) do
        Hydramata::Deposit.should_receive(:new_form_for).with(controller, work_type).and_return(work_form)
        Hydramata::Deposit.should_receive(:authorize!).with(controller, work_form).and_return(true)
      end

      context 'GET #new' do
        it 'should assign a :work' do
          get :new, work_type: work_type, use_route: :hydramata_deposit
          expect(assigns(:work)).to respond_to :fieldsets
        end
      end

      context 'POST #create' do
        context 'valid attributes' do
          it 'should assign a work and redirect to completion path' do
            post :create, work_type: work_type, work: { title: 'Hello' }, use_route: :hydramata_deposit
            expect(assigns(:work)).to eq(work_form)
            expect(response).to be_redirect
          end
        end

        context 'invalid attributes' do
          it 'should assign a work and render new action' do
            post :create, work_type: work_type, work: { title: ''}, use_route: :hydramata_deposit
            expect(response).to be_success
            expect(response).to render_template('new')
          end
        end
      end

    end

    context 'edit/update' do
      let(:work_form) { work_form_class.new(controller, pid) }
      before(:each) do
        Hydramata::Deposit.should_receive(:existing_form_for).with(controller, pid).and_return(work_form)
        Hydramata::Deposit.should_receive(:authorize!).with(controller, work_form).and_return(true)
      end
      context 'GET #edit' do

        it 'should assign a :work' do
          get :edit, id: pid, use_route: :hydramata_deposit
          expect(assigns(:work)).to eq(work_form)
          expect(response).to be_success
        end
      end

      context 'PUT #update' do
        it 'should assign a work and redirect to completion path' do
          work_form.should_receive(:save)
          put :update, id: pid, work: { title: 'Hello' }, use_route: :hydramata_deposit
          expect(assigns(:work)).to eq(work_form)
          expect(response).to be_redirect
        end
      end
    end

    context 'show' do
      before(:each) do
        Hydramata::Deposit.should_receive(:existing_form_for).with(controller, pid).and_return(work_presenter)
        Hydramata::Deposit.should_receive(:authorize!).with(controller, work_presenter).and_return(true)
      end
      context 'GET #show' do
        let(:work_presenter_class) { Hydramata::FormFinalizer.call(work_type, work_form_configuration) }
        let(:work_presenter) { work_presenter_class.new(controller, pid) }
        it 'should assign a :work' do
          get :show, id: pid, use_route: :hydramata_deposit
          expect(assigns(:work)).to eq(work_presenter)
          expect(response).to be_success
        end
      end
    end

    context 'index' do
      context 'GET #index' do
        before(:each) do
          Hydramata::Deposit.should_receive(:query_works).with(controller, hash_including(work_type: work_type)).and_return(work_query_results)
        end
        let(:work_query_results) { double }
        it 'should assign a :works' do
          get :index, work_type: work_type, use_route: :hydramata_deposit
          expect(assigns(:works)).to eq(work_query_results)
          expect(response).to be_success
        end
      end
    end
  end
end
