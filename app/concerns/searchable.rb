module Searchable
  extend ActiveSupport::Concern

  class_methods do
    def search_by(term, *fields)
      return all if term.blank?

      conditions = fields.map { |field| "#{field} ILIKE ?" }.join(" OR ")
      values = fields.map { |field| "%#{term}%" }

      where(conditions, *values)
    end

    def search_by_date_range(start_date, end_date, date_field = :created_at)
      return all if start_date.blank? && end_date.blank?

      scope = all
      scope = scope.where("#{date_field} >= ?", start_date) if start_date.present?
      scope = scope.where("#{date_field} <= ?", end_date) if end_date.present?

      scope
    end
  end
end
