class Category < ApplicationRecord
  has_many :pages, dependent: :destroy
end
