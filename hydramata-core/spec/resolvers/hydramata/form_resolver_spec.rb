require 'spec_helper'

module Hydramata
  describe FormResolver do
    before(:each) do
      @controller = Class.new(ApplicationController) do
        self.view_paths = [
          ActionView::FixtureResolver.new("hydramata/_title.html.erb" => "Hydramata/Title"),
          ActionView::FixtureResolver.new("hydramata/attribute/_title.html.erb" => "Hydramata/Attribute/Title"),
        ]

        prepend_view_path Hydramata::FormResolver.new(self, /\Ahydramata/)
      end.new
    end

    let(:controller) { @controller }
    let(:details) { {formats: [:html], locale: [:en], handlers: [:erb] } }
    let(:prefix_scope) { /\Ahydramata/ }
    subject { Hydramata::FormResolver.new(controller, prefix_scope) }

    it 'should ignore non-partials' do
      expect(subject.find_all('index', 'garble', false, details)).to be_empty
    end

    it 'should ignore non-matching scopes' do
      expect(subject.find_all('title', 'spam/hydramata/attribute', true, details)).to be_empty
    end

    it 'should resolve on partial with matching scope' do
      template = subject.find_all('title', 'hydramata/attribute', true, details).first

      # Note we found the better match in hydramata/attribute/_title as opposed to
      # hydramata/_title
      expect(template.source).to eq("Hydramata/Attribute/Title")
    end
  end
end
