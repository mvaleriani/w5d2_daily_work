# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  title      :string
#  url        :string
#  content    :text
#  sub_id     :integer
#  author_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Post < ApplicationRecord
  validates :title, presence: true

  belongs_to :sub

  belongs_to :author,
    foreign_key: :author_id,
    class_name: :User

  has_many :postsubs,
    foreign_key: :post_id,
    class_name: :PostSub

  has_many :cross_subs,
    through: :postsubs,
    source: :sub
end
