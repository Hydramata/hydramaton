class Hydramata::Policy < ActiveRecord::Base
  self.table_name = 'hydramata_policies'

  validates :name, uniqueness: true, presence: true
  has_many :elements, class_name: 'Hydramata::PolicyElement'
  def self.query(options = {})
    elements_quoted_table_name = reflect_on_association(:elements).quoted_table_name

    where_collector = includes(:elements)

    if group_identifiers = options.fetch(:group_identifiers) { nil }
      where_collector = where_collector.where("#{elements_quoted_table_name}.group_identifier IN (?)", group_identifiers)
    end

    if action_names = options.fetch(:action_names) { nil }
      where_collector = where_collector.where("#{elements_quoted_table_name}.action_name IN (?)", action_names)
    end

    where_collector.references(:elements)
  end
end
