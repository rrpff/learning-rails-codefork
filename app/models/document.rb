class Document < ActiveRecord::Base
    belongs_to :user
    validates :name, :language, :content,
        presence: true,
        length: {
            minimum: 1
        }
end