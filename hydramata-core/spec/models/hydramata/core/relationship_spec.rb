require 'spec_helper'

module Hydramata::Core
  describe Relationship do
    Given(:predicate) { 'is_author_of' }
    Given(:creator) { double('Creator', id: '123' ) }
    Given(:subject) { double('Subject', id: '456' ) }
    Given(:target) { double('Target', id: '789' ) }
    context '.query' do
      context 'single predicate' do
        Given!(:relationship) { Relationship.create(predicate: predicate, creator: creator, subject: subject, target: target)}
        When(:result) { Relationship.query(predicate: predicate, creator: creator) }
        Then { expect(result).to eq([relationship]) }
      end
      context 'multipe predicates' do
        Given(:other_predicate) { 'is_managing_member_of' }
        Given!(:relationship1) { Relationship.create(predicate: predicate, creator: creator, subject: subject, target: target)}
        Given!(:relationship2) { Relationship.create(predicate: other_predicate, creator: creator, subject: subject, target: target)}
        When(:result) { Relationship.query(predicate: [predicate, other_predicate], creator: creator) }
        Then { expect(result).to eq([relationship1, relationship2]) }
      end
      context 'cannot yet handle multipe creators' do
        Given!(:relationship) { Relationship.create(predicate: predicate, creator: creator, subject: subject, target: target)}
        When(:result) { Relationship.query(creator: [creator,creator]) }
        Then { expect(result).to have_raised(NoMethodError) }
      end
      context 'cannot yet handle multipe subjects' do
        Given!(:relationship) { Relationship.create(predicate: predicate, creator: creator, subject: subject, target: target)}
        When(:result) { Relationship.query(subject: [subject,subject]) }
        Then { expect(result).to have_raised(NoMethodError) }
      end
      context 'cannot yet handle multipe targets' do
        Given!(:relationship) { Relationship.create(predicate: predicate, creator: creator, subject: subject, target: target)}
        When(:result) { Relationship.query(target: [target,target]) }
        Then { expect(result).to have_raised(NoMethodError) }
      end
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
