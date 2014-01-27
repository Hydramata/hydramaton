require 'spec_helper'

module Hydramata
  describe FormFieldset do
    let(:form) { double(work_type: :article) }
    let(:name) { :required }
    let(:attributes) { [{name: :title, type: String, options: {}}] }
    subject { Hydramata::FormFieldset.new(form, name, attributes)}
    its(:name) { should == name }
    its(:form) { should == form }
    its(:attribute_names) { should == [:title] }
    its(:work_type) { should == form.work_type }

    context '#attributes' do
      subject { Hydramata::FormFieldset.new(form, name, attributes).attributes }
      it 'should extract the name' do
        expect(subject.first.name).to eq(:title)
      end
    end

    context '#render' do
      subject { Hydramata::FormFieldset.new(form, name, attributes) }
      let(:template) { double("Template") }
      let(:form_builder) { double("Builder", template: template) }
      it 'should render each attribute' do
        template.should_receive("render").with(subject.partial_path, {f: form_builder, fieldset: subject})
        subject.render(form_builder)
      end
    end
  end
end
