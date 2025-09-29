module Paginatable
  extend ActiveSupport::Concern

  DEFAULT_PER_PAGE = 20

  class_methods do
    def paginate(collection, page: 1, per_page: DEFAULT_PER_PAGE)
      page = [ page.to_i, 1 ].max
      per_page = [ per_page.to_i, 1 ].max

      offset = (page - 1) * per_page
      paginated_collection = collection.limit(per_page).offset(offset)

      {
        collection: paginated_collection,
        current_page: page,
        per_page: per_page,
        total_count: collection.count,
        total_pages: (collection.count.to_f / per_page).ceil
      }
    end
  end
end
