class Output < ActiveRecord::Base
  belongs_to :employee
  belongs_to :warehouse
  belongs_to :product

  validates :quantity, :product, :warehouse, :employee, presence: true

  def self.search(options)
    search_start, search_end = options[:search_start], options[:search_end]

    return all if search_start.blank? && search_end.blank?

    if search_start.present? && search_end.present?
      where("created_at >= ? AND created_at <= ?", search_start.to_datetime, search_end.to_datetime)
    elsif search_start.present?
      where("created_at >= ?", search_start.to_datetime)
    elsif search_end.present?
      where("created_at <= ?", search_end.to_datetime)
    end
  end
end
