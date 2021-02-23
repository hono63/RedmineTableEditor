require_dependency 'rte_hook_listener'

Redmine::Plugin.register :redmine_table_editor do
  name 'Table Editor plugin'
  author 'hono63'
  description 'This plugin replaces views/issues/_list.html.erb'
  version '0.0.1'
  url 'https://github.com/hono63/RedmineTableEditor'
  author_url 'https://github.com/hono63'
end
