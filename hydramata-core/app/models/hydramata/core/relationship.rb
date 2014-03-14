# A Relationship is made of 4 attributes:
# * Subject
# * Predicate
# * Target
# * Creator - who created the relationship
#
# In Triples-speak, Subject Predicate Object maps to Subject Predicate Target,
# but I don't want to define object_id and object_type in the database as that
# can create all kinds of havoc with Ruby's internal object_id
class Hydramata::Core::Relationship < ActiveRecord::Base
  validates :subject_id, presence: true
  validates :subject_type, presence: true
  validates :predicate, presence: true
  validates :target_id, presence: true
  validates :target_type, presence: true
  validates :authority_id, presence: true
  validates :authority_type, presence: true

  def self.subjects_for(collaborators = {})
    query(collaborators).map { |obj| obj.subject }
  end

  def self.query(collaborators = {})
    extractor = ParameterExtractor.new(collaborators)
    where(extractor.to_hash)
  end

  # Overwriting the initialize so that we take objects which are extracted
  # to their composite identifier (i.e. subject becomes subject_id, subject_type)
  def initialize(attributes = {}, &block)
    extractor = ParameterExtractor.new(attributes)
    super(extractor.to_hash, &block)
  end

  def subject
    subject_type.constantize.find(subject_id)
  end

  def target
    target_type.constantize.find(target_id)
  end

  def authority
    authority_type.constantize.find(authority_id)
  end

  class ParameterExtractor
    def initialize(collaborators = {})
      @subject = collaborators[:subject]
      @target = collaborators[:target]
      self.predicate = collaborators[:predicate]
      @authority = collaborators[:authority]
    end

    def to_hash
      returning_value = {}
      returning_value[:subject_id] = subject_id if subject_id.present?
      returning_value[:subject_type] = subject_type if subject_type.present?
      returning_value[:predicate] = predicate if predicate.present?
      returning_value[:target_id] = target_id if target_id.present?
      returning_value[:target_type] = target_type if target_type.present?
      returning_value[:authority_id] = authority_id if authority_id.present?
      returning_value[:authority_type] = authority_type if authority_type.present?
      returning_value
    end

    def subject_id
      @subject.present? ? @subject.id : nil
    end

    def subject_type
      @subject.present? ? @subject.class.to_s : nil
    end

    def target_id
      @target.present? ? @target.id : nil
    end

    def target_type
      @target.present? ? @target.class.to_s : nil
    end

    def authority_id
      @authority.present? ? @authority.id : nil
    end

    def authority_type
      @authority.present? ? @authority.class.to_s : nil
    end

    attr_reader :predicate
    protected
    def predicate=(value)
      @predicate = value
    end

  end
end
