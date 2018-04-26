class Attachment < ApplicationRecord
belongs_to :type

  validates_presence_of :sequence
  validates_presence_of :type
end
