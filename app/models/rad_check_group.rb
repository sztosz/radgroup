class RadCheckGroup < ApplicationRecord
  validates :groupname, :attr, :op, :value, presence: true
end