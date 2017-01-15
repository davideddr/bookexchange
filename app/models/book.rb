class Book < ActiveRecord::Base
  has_many :provides
  has_many :wishlists
  belongs_to :user

  has_attached_file :cover, styles: { medium: '300x300>', thumb: '100x100>', format: %w(jpg png) }, default_url: '/images/missing.png'
  validates_attachment_content_type :cover, content_type: /\Aimage\/.*\Z/

  validates :title, presence: true
  validates :isbn, presence: true, length: 10..13, allow_blank: false
  validates :language, presence: true
  validates :typeOfSale, presence: true, inclusion: { in: %w(Sale Loan Donation Vendita Prestito Donazione) }
  validates :status, presence: true

  STATUS = [_('New'), _('Like new'), _('Excellent'), _('Good condition'), _('Discrete model'), _('Bad condition')].freeze
  CAT = [_('Arts & Entertainment'), _('Action & Adventure'), _('Biographies and diaries'), _('Law'), _('Business & Finance'), _('Science Fiction, Fantasy and Horror'), _('Comics & Graphic Novels'), _('Gialli and Thriller '), _('Humor'), _('Computers & Technology'), _('Literature & Fiction'), _('Books for children'), _('School books'), _('Language, linguistics and writing'), _('Historical Fiction'), _('Politics'), _('Religion'), _('Romance'), _('Science & Technology'), _('Sport'), _('History')].freeze
  TYPE = [_('Sale'), _('Loan'), _('Donation')].freeze

  scope :title_like, ->(title) { where('title like ?', title) }

  def self.build(result)
    Book.new(title: result.title, isbn: result.isbn.to_s,
      language: result.language, author: result.authors, publisher: result.publisher,
      pages: result.page_count, description: result.description, year: result.published_date)
  end
end
