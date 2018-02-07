class Article < ApplicationRecord
    belongs_to :user
    has_many :comments
    validates :title, uniqueness: true
    validates :body, length: {minimum: 20} 
    before_save :set_visits_count

    has_attached_file :cover, style: { medium: "1280x720", thumb: "800x600" }
    validates_attachment_content_type :cover, content_type: /\Aimage\/.*\Z/

    def update_visits_count
        self.update(visits_count: self.visits_count + 1)
    end

    private

    def set_visits_count
        #Si el valor es nulo asigna cero, sino mantenlo
        self.visits_count ||= 0
    end
end
