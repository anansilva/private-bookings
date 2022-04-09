module ApplicationHelper
  def navigation_items
    [
      {
        body: 'Casas',
        href: listings_path
      },
      {
        body: 'Reservas',
        href: ''
      },
      {
        body: 'Gerir casas',
        href: admin_listings_path
      }
    ]
  end

  def navigation_class(path)
    if current_page?(path)
      "bg-gray-900 text-white px-3 py-2 rounded-md text-sm font-medium"
    else
      "text-gray-300 hover:bg-gray-700 hover:text-white px-3 py-2 rounded-md text-sm font-medium"
    end
  end

  def mobile_navigation_class(path)
    if current_page?(path)
      "block px-3 py-2 text-base font-medium text-white bg-gray-900 hover:bg-gray-700 hover:text-white rounded-md"
    else
      "block px-3 py-2 text-base font-medium text-gray-300 hover:bg-gray-700 hover:text-white rounded-md"
    end
  end

  def navigation_aria(path)
    if current_page?(path)
      'page'
    else
      'false'
    end
  end
end
