require 'spec_helper'

module Hydramata::Core
  describe Relationship do
    Given(:predicate) { 'is_author_of' }
    Given(:creator) { double('Creator', id: '123' ) }
    Given(:subject) { double('Subject', id: '456' ) }
    Given(:target) { double('Target', id: '789' ) }
    context '.query' do
      Given!(:relationship) { Relationship.create(predicate: predicate, creator: creator, subject: subject, target: target)}
      Then { expect(Relationship.last).to eq(relationship) }
    end
  end
  describe Relationship::ParameterExtractor do
    Given(:predicate) { 'is_author_of' }
    Given(:creator) { double('Creator', id: '123' ) }
    Given(:subject) { double('Subject', id: '456' ) }
    Given(:target) { double('Target', id: '789' ) }
    Given(:normalizer) { Relationship::ParameterExtractor.new({predicate: 'is_author_of', creator: creator, subject: subject, target: target}) }
    When(:result) { normalizer.to_hash }
    Then { expect(result).to eq({subject_id: subject.id, subject_type: subject.class.to_s, predicate: 'is_author_of', target_id: target.id, target_type: target.class.to_s, creator_id: creator.id, creator_type: creator.class.to_s})}
  end
end
