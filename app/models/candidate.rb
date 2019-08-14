class Candidate < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable
end
