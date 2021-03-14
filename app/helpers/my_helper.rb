
module MyHelper
  include ApplicationHelper

  # QueryHelper‚Ìcolumn_header‚ğ‰ü‘¢
  def tabu_column_header(query, column, options={})
    if column.sortable?
      css, order = nil, column.default_order
      if column.name.to_s == query.sort_criteria.first_key
        if query.sort_criteria.first_asc?
          css = 'sort asc icon icon-sorted-desc'
          order = 'desc'
        else
          css = 'sort desc icon icon-sorted-asc'
          order = 'asc'
        end
      end
      param_key = options[:sort_param] || :sort
      sort_param = {param_key => query.sort_criteria.add(column.name, order).to_param}
      sort_param = {$1 => {$2 => sort_param.values.first}} while sort_param.keys.first.to_s =~ /^(.+)\[(.+)\]$/
      link_options = {
        :title => l(:label_sort_by, "\"#{column.caption}\""),
        :class => css
      }
      if options[:sort_link_options]
        link_options.merge! options[:sort_link_options]
      end
      content =
        link_to(
          column.caption,
          {:params => request.query_parameters.deep_merge(sort_param)},
          link_options
        )
    else
      content = column.caption
    end
    content_tag('th', content, :class => column.css_classes)
  end