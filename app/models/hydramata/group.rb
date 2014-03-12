class Hydramata::Group < ActiveRecord::Base
  self.table_name = 'hydramata_groups'

  class Form
    include Virtus.model
    include ActiveModel::Validations

    attribute :name, String
    validates :name, presence: true

    attribute :group, Hydramata::Group
    validates :group, presence: true

    delegate :to_param, :to_key, :id, :persisted, to: :group

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
