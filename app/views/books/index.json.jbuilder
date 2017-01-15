json.array!(@books) do |book|
  json.extract! book, :id, :title, :autor, :publisher, :isbn, :pages, :year, :description, :bookbinding, :language, :category, :typeOfSale, :status
  json.url book_url(book, format: :json)
end
