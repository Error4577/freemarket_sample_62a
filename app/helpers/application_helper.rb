module ApplicationHelper
  def lazysizes_image_tag(source, options={})
    options['data-src'] = source
    if options[:class].blank?
      options[:class] = "lazyload"
    else
      options[:class] = "lazyload #{options[:class]}"
    end
    image_tag("hoge.png", options) + ("<noscript>#{image_tag(source, options)}</noscript>").html_safe
  end
end
