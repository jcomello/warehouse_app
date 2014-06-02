class Input < ActiveRecord::Base
  belongs_to :employee
  belongs_to :warehouse
  belongs_to :product

  validates :quantity, :product, :warehouse, :employee, presence: true

  def self.search(options)
    search_start, search_end = options[:search_start], options[:search_end]

    return all if search_start.blank? && search_end.blank?
    where("created_at >= ?", search_start.to_datetime) if search_start.present?
    where("created_at <= ?", search_end.to_datetime) if search_end.present?
  end
end
