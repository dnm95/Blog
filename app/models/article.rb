class Article < ApplicationRecord
    belongs_to :user
    has_many :comments
    has_many :has_categories
    has_many :categories, through: :has_categories

    validates :title, uniqueness: true
    validates :body, length: {minimum: 20} 
    before_save :set_visits_count
    after_create :save_categories
    after_create :send_mail

    has_attached_file :cover, style: { medium: "1280x720", thumb: "800x600" }
    validates_attachment_content_type :cover, content_type: /\Aimage\/.*\Z/

    scope :ultimos, ->{ order("created_at DESC") }

    #Custom setter
    def categories=(value)
        @categories = value
    end

    def send_mail 
        ArticleMailer.new_article(self).deliver_later
    end

    def save_categories
        @categories.each do |category_id|
            HasCategory.create(category_id: category_id,article_id: self.id)
        end
    end
    
    def update_visits_count
        self.update(visits_count: self.visits_count + 1)
    end

    private

    def set_visits_count
        #Si el valor es nulo asigna cero, sino mantenlo
        self.visits_count ||= 0
    end
end
