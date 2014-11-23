class Favorite < ActiveRecord::Base
  belongs_to :user
  belongs_to :neighborhood
  validates :user_id, :neighborhood_id, presence: true
  validate :favorite_is_unique

  private

    def favorite_is_unique
      duplicates = Favorite.where(user_id: self.user_id, neighborhood_id: self.neighborhood_id)
      if duplicates.size > 0
        errors.add(:id, 'user_id and neighborhood_id must be unique')
      end
    end

end
