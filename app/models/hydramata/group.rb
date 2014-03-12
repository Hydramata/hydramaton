module Hydramata
  class Group < ActiveRecord::Base
    self.table_name = 'hydramata_groups'

    def self.new_form_for(user)
      group = Group.new
      Group::Form.new(group: group, creator: user)
    end

    class Form
      include Virtus.model
      include ActiveModel::Validations

      attribute :name, String
      validates :name, presence: true

      validates :group, presence: true
      validates :creator, presence: { unless: lambda {|form| form.persisted? } }

      attr_reader :creator, :group
      def initialize(input = {}, &block)
        attrs = input.with_indifferent_access
        @group = attrs.fetch(:group)
        @creator = attrs.delete(:creator)
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

    end
  end
end
