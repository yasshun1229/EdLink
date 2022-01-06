class Project < ApplicationRecord
  belongs_to :user
  
  with_options presence: true, length: { maximum: 50 } do # カラ禁止、50字以内
    validates :project_name
  end
  
  with_options presence: true, length: { maximum: 500 } do # カラ禁止、500字以内
    validates :explanation
  end
end
