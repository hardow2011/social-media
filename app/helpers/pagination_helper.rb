module PaginationHelper

  # Replace with POSTS_PER_PAGE
  def posts_per_page
    return 5
  end

  POSTS_PER_PAGE = 5

  class Pagination
    attr_reader :page, :items
    def initialize(page, items, posts_per_page = POSTS_PER_PAGE)
      # If page arg lower than 1, then make @page = 1...
      # otherwise keep @page = page
      page = page.to_i

      @page = page < 1 ? 1 : page

      @last_page = (items.size.to_f / posts_per_page).ceil
      @last_page = @last_page == 0 ? 1 : @last_page

      if @page > @last_page
        @page = @last_page
        @has_next_page = false
        @items = items.page(@last_page, posts_per_page)
      else
        @has_next_page = true
        @items = items.page(@page, posts_per_page)
      end

      @has_previous_page = @page  <= 1 ? false : true
    end
  end
end
