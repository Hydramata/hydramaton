require 'spec_helper'

module Hydramata::Core
  describe Engine do
    shared_examples "a valid Hydramata::FormClassBuilder" do |work_type|
      let(:helpful_class_name) do
        /\AHydramata::FormClassBuilder\(#{work_type}/
      end
      its(:work_type) { should eq work_type }
      its(:inspect) { should match helpful_class_name }
      its(:to_s) { should match helpful_class_name }
      its(:finalizer_config) { should be_a_kind_of Hash }
      it { should respond_to(:new) }
      context 'an instance' do
        let(:context) { double }
        let(:instance) { subject.new(context) }
        it { expect(instance).to respond_to(:valid?)}
        it 'should not raise an error on #valid?' do
          expect{ instance.valid? }.to_not raise_error
        end
      end
    end
    context '.register_new_form_for' do

      context ':generic_work form' do
        subject { Hydramata::Core.finalize_new_form_for(:generic_work) }
        it_behaves_like "a valid Hydramata::FormClassBuilder", :generic_work
      end

      context ':article form' do
        subject { Hydramata::Core.finalize_new_form_for(:article) }
        it_behaves_like "a valid Hydramata::FormClassBuilder", :article
      end

      context ':dataset form' do
        subject { Hydramata::Core.finalize_new_form_for(:dataset) }
        it_behaves_like "a valid Hydramata::FormClassBuilder", :dataset
      end

      context ':document form' do
        subject { Hydramata::Core.finalize_new_form_for(:document) }
        it_behaves_like "a valid Hydramata::FormClassBuilder", :document
      end

      context ':image form' do
        subject { Hydramata::Core.finalize_new_form_for(:image) }
        it_behaves_like "a valid Hydramata::FormClassBuilder", :image
      end
    end
  end
end
