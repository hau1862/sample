class Micropost < ApplicationRecord
  MICROPOST_PARAMS = %i(content image).freeze
  belongs_to :user
  has_one_attached :image

  validates :user_id, presence: true
  validates :content, presence: true,
                      length: {maximum: Settings.content.length.max}
  validates :image,
            content_type: {in: Settings.image.type,
                           message: :valid_format_image},
            size: {less_than: Settings.image.size.megabytes,
                   message: :image_size_warning}

  scope :newest, ->{order(created_at: :desc)}
  scope :by_user_ids, ->(user_ids){where user_id: user_ids}

  delegate :name, to: :user, prefix: true

  def display_image
    image.variant resize_to_limit: Settings.image_micropost_size
  end
end
