class RteHookListener < Redmine::Hook::ViewListener
    def view_issues_index_bottom(context = {})
        return content_tag("p", "Custom content on bottom")
        #return <<"EOS"
#<link href="https://unpkg.com/tabulator-tables@4.9.3/dist/css/tabulator.min.css" rel="stylesheet">
#<script type="text/javascript" src="https://unpkg.com/tabulator-tables@4.9.3/dist/js/tabulator.min.js"></script>
#<script type="text/javascript">
#alert("Hello");
#</script>
#EOS
    end
end