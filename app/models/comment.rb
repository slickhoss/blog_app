class Comment < ApplicationRecord
  belongs_to :article, dependent: :destroy
  belongs_to :user, dependent: :destroy

  validates :body ,presence: true
end
