module ApplicationHelper
  def get_bread_crumb(url)
    begin
      breadcrumb = ''
      so_far = '/'
      elements = url.split('/')
      for i in 1...elements.size

        so_far += elements[i] + '/'

        if elements[i] =~ /^\d+$/
          begin
            breadcrumb += link_to_if(i != elements.size - 1, eval("#{elements[i - 1].singularize.camelize}.find(#{elements[i]}).name").gsub("_"," ").to_s, so_far)
          rescue
            breadcrumb += elements[i]
          end
        else
          breadcrumb += link_to_if(i != elements.size - 1,elements[i].gsub("_"," ").titleize, so_far)
        end

        breadcrumb += " &raquo; " if i != elements.size - 1
      end
      breadcrumb
    rescue
      'Not available'
    end
  end
  def store_title(param)
    ret=""
    if param[:controller]=='products'
      if param[:id] && !param[:cart_id]
        ret += Product.find(param[:id]).title.to_s
        ret += ' - '
        ret += Product.find(param[:id]).price.to_s+'грн.'
        ret += ' | '
      end
    end
    if param[:category_id]
      ret += Category.find(param[:category_id]).name.to_s
      ret += ' | '
    end
    if param[:author_id]
      ret += Author.find(param[:author_id]).name.to_s
      ret += ' | '
    end
    ret += 'Магазин изделий ручной работы РoshStore.com.ua'

    ret
  end
end
