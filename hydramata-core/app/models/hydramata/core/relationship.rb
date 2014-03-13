class Hydramata::Core::Relationship < ActiveRecord::Base
  validates :subject_id, presence: true
  validates :subject_type, presence: true
  validates :predicate, presence: true
  validates :target_id, presence: true
  validates :target_type, presence: true
  validates :creator_id, presence: true
  validates :creator_type, presence: true

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

  def creator
    creator_type.constantize.find(creator_id)
  end

  class ParameterExtractor
    def initialize(collaborators = {})
      @subject = collaborators[:subject]
      @target = collaborators[:target]
      self.predicate = collaborators[:predicate]
      @creator = collaborators[:creator]
    end

    def to_hash
      returning_value = {}
      returning_value[:subject_id] = subject_id if subject_id.present?
      returning_value[:subject_type] = subject_type if subject_type.present?
      returning_value[:predicate] = predicate if predicate.present?
      returning_value[:target_id] = target_id if target_id.present?
      returning_value[:target_type] = target_type if target_type.present?
      returning_value[:creator_id] = creator_id if creator_id.present?
      returning_value[:creator_type] = creator_type if creator_type.present?
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

    def creator_id
      @creator.present? ? @creator.id : nil
    end

    def creator_type
      @creator.present? ? @creator.class.to_s : nil
    end

    attr_reader :predicate
    protected
    def predicate=(value)
      @predicate = value
    end

  end
end
