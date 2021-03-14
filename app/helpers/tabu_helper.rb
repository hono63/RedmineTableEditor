#
#module TabuHelper
#  include ApplicationHelper
#
#  def tabu_column_header(query, column, options={})
#    if column.sortable?
#      css, order = nil, column.default_order
#      if column.name.to_s == query.sort_criteria.first_key
#        if query.sort_criteria.first_asc?
#          css = 'sort asc icon icon-sorted-desc'
#          order = 'desc'
#        else
#          css = 'sort desc icon icon-sorted-asc'
#          order = 'asc'
#        end
#      end
#      param_key = options[:sort_param] || :sort
#      sort_param = {param_key => query.sort_criteria.add(column.name, order).to_param}
#      sort_param = {$1 => {$2 => sort_param.values.first}} while sort_param.keys.first.to_s =~ /^(.+)\[(.+)\]$/
#      link_options = {
#        :title => l(:label_sort_by, "\"#{column.caption}\""),
#        :class => css
#      }
#      if options[:sort_link_options]
#        link_options.merge! options[:sort_link_options]
#      end
#      content =
#        link_to(
#          column.caption,
#          {:params => request.query_parameters.deep_merge(sort_param)},
#          link_options
#        )
#    else
#      content = column.caption
#    end
#    #content_tag('th', content, :class => column.css_classes)
#    render :json => {
#        :title => column.caption.to_s,
#        :field =>  column.name.to_s, 
#    }
#  end
#
#  def tabu_column_content(column, item)
#    value = column.value_object(item)
#    if value.is_a?(Array)
#      values = value.collect {|v| tabu_column_value(column, item, v)}.compact
#      safe_join(values, ', ')
#    else
#      tabu_column_value(column, item, value)
#    end
#  end
#
#  def tabu_column_value(column, item, value)
#    case column.name
#    when :id
#      link_to value, issue_path(item)
#    when :subject
#      link_to value, issue_path(item)
#    when :parent
#      value ? (value.visible? ? link_to_issue(value, :subject => false) : "##{value.id}") : ''
#    when :description
#      item.description? ? content_tag('div', textilizable(item, :description), :class => "wiki") : ''
#    when :last_notes
#      item.last_notes.present? ? content_tag('div', textilizable(item, :last_notes), :class => "wiki") : ''
#    when :done_ratio
#      progress_bar(value)
#    when :relations
#      content_tag(
#        'span',
#        value.to_s(item) {|other| link_to_issue(other, :subject => false, :tracker => false)}.html_safe,
#        :class => value.css_classes_for(item))
#    when :hours, :estimated_hours, :total_estimated_hours
#      format_hours(value)
#    when :spent_hours
#      link_to_if(value > 0, format_hours(value), project_time_entries_path(item.project, :issue_id => "#{item.id}"))
#    when :total_spent_hours
#      link_to_if(value > 0, format_hours(value), project_time_entries_path(item.project, :issue_id => "~#{item.id}"))
#    when :attachments
#      value.to_a.map {|a| format_object(a)}.join(" ").html_safe
#    else
#      format_object(value)
#    end
#  end