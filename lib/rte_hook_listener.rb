class RteHookListener < Redmine::Hook::ViewListener
    def view_projects_show_left(context = {})
        return content_tag("p", "Custom content on left side")
    end
end