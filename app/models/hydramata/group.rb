module Hydramata
  class Group < ActiveRecord::Base
    self.table_name = 'hydramata_groups'

    def self.new_form_for(user)
      group = Group.new
      Form.new(group: group, creator: user)
    end

    def self.existing_form_for(user, identifier)
      group = Group.find(identifier)
      Form.new(group: group)
    end

    # A potentially over-worked class (it must handle the create and update
    # context of a Group). However it does separate the concerns of marshalling
    # data from the persistence layer.
    class Form
      include Virtus.model
      include ActiveModel::Validations

      attribute :name, String
      validates :name, presence: true

      attr_reader :creator, :group
      def initialize(input = {}, &block)
        extract_collaborators(input)
        super(input, &block)
      end

      delegate :to_param, :to_key, :id, :persisted?, to: :group

      def self.model_name
        Hydramata::Group.model_name
      end

      def create
        valid? ? __create : false
      end
      alias_method :save, :create

      def __create
        group.attributes = { name: name }
        group.save
      end
      private :__create

      def update(attributes = {})
        self.attributes = attributes
        valid? ? __update : false
      end

      def __update
        group.update(name: name)
      end
      private :__update

      def extract_collaborators(input)
        attrs = input.with_indifferent_access

        # Instead of relying on validation that the application's user cannot
        # nor should not specify, I want to raise exceptions. This means that
        # the issue is on the developer to fix.
        @group = attrs.fetch(:group)
        @creator = attrs.fetch(:creator) unless persisted?
      end
      private :extract_collaborators
    end

  end
end
