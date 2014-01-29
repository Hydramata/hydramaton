require 'spec_helper'

module Hydramata
  describe 'MultiValueInput' do

    class Foo
      extend ActiveModel::Naming
      include ActiveModel::Conversion
      include ActiveModel::Validations
      def persisted?; false; end
      attr_accessor :bar
    end

    let(:foo) { Foo.new }
    let(:bar) { ["bar1", "bar2"] }
    subject {
      foo.bar = bar
      input_for(foo, :bar,
                {
                  as: 'hydramata/multi_value',
                  required: true
                }
                )
    }

    describe 'happy case' do
      it 'renders multi-value' do
        expect(subject).to have_tag('.hydramata_foo_bar.multi_value') do
          with_tag('label.multi_value.required', {text: '* Bar', with: {:for => 'hydramata_foo_bar'}}) do
            with_tag("abbr")
          end
          with_tag('ul.listing') do
            with_tag('li.field-wrapper') do
              with_tag('input.hydramata_foo_bar.required.multi-text-field#hydramata_foo_bar', with: {name: 'hydramata_foo[bar][]', value: 'bar1', required: 'required'})
            end
            with_tag('li.field-wrapper') do
              with_tag('input.hydramata_foo_bar.multi-text-field', with: {name: 'hydramata_foo[bar][]', value: 'bar2'}, without: {required: 'required'})
            end
            with_tag('li.field-wrapper') do
              with_tag('input.hydramata_foo_bar.multi-text-field', with: {name: 'hydramata_foo[bar][]', value: ''}, without: {required: 'required'})
            end
          end
        end
      end
    end
  end
end
