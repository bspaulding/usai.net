# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

	def tiny_mce_editor_tag
		javascript_include_tag("/javascripts/tiny_mce/tiny_mce.js") + "\n<script language=\"javascript\" type=\"text/javascript\">
			tinyMCE.init({
			theme : \"advanced\",
			theme_advanced_disable : \"link,unlink,image,cleanup\",
			mode : \"textareas\"
		});
		</script>"
	end
end
