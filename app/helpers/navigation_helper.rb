module NavigationHelper
  def navigation
    @navigation ||= Navigation.new(Taxonomy.instance.tree)
  end

  def navigation_topics(topics)
    capture do
      topics.map do |topic|
        concat navigation_topic(topic, last: (topic == topics.last))
      end
    end
  end

  def navigation_topic(topic, last: false)
    item_classes = %w(nav__item)
    item_classes << 'nav__item--single' if last

    group_classes = %w(nav__sub-nav)
    group_classes << 'nav__sub-nav--left' if last
    group_classes << 'nav__sub-nav--double' if topic.items.size == 2

    content_tag(:li, class: item_classes) do
      concat navigation_topic_link(topic)
      concat navigation_topic_list(topic.items.reverse, group_classes)
    end
  end

  private

  def navigation_topic_link(topic)
    link_to(topic.label, topic.url, class: 'nav__item-label', 'aria-haspopup': true)
  end

  def navigation_topic_list(groups, classes)
    content_tag(:div, class: classes) do
      groups.each_with_index { |items, index| concat navigation_group(items, position: index + 1) }
    end
  end

  def navigation_group(group, position:)
    classes = %w(nav__sub-nav-list)
    classes << case position
               when 1 then
                 'nav__sub-nav-list--first'
               when 2 then
                 'nav__sub-nav-list--second'
               end

    content_tag(:ul, class: classes) do
      group.map { |item| concat navigation_item(item) }
    end
  end

  def navigation_item(item)
    classes = %w(nav__item)
    classes << 'nav__item--parent' if item.parent

    content_tag(:li, class: classes) do
      navigation_link(item)
    end
  end

  def navigation_link(item)
    if item.option
      capture do
        concat content_tag(:span, nil, class: "circle circle--s circle--#{item.id}")
        concat link_to(item.label, item.url, class: 'has-circle')
      end
    else
      link_to(item.label, item.url)
    end
  end
end
