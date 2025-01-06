class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :question
  belongs_to :diagnosis, inverse_of: :answers
end
