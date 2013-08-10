// search_field.js
// --------------------
// Author: Bradley J. Spaulding, USAi.net
//
// Updated Log:
// [2010-01-05] Migrated to JQuery
//

// Avoid conflict with Prototype
var $j = jQuery.noConflict();

//Adds Search Field Support for browsers other than Safari
$j(document).ready(function() {
	// Grab the search field and store it off in a variable.
	searchField = $j("#siteSearch");
	
	// Only add functionality if <input type="search"...> was not supported. 
	// NOTE: Currently this input type is only supported in Safari.
	if(searchField.attr("type") == "text") {
    // Store off the default text
    searchFieldDefaultText = "Search USAi.net...";
    
		// Set the default value
		searchField.attr("value", searchFieldDefaultText);
		// Set the class of the search field (must remove the default safari class.
		searchField.removeClass("siteSearch_safari");
		searchField.addClass("siteSearch");
		
		// Add Focus Behavior
    searchField.focus(function(e) {
			if($j(this).attr("value") == searchFieldDefaultText) $j(this).attr("value", "");
			$j(this).css("background", "#b6d2ff");
			$j(this).css("color", "#ffffff");
		});
		
		// Add Blur Behavior
		searchField.blur(function(e) {
			if($j(this).attr("value") == "") $j(this).attr("value", searchFieldDefaultText);
			$j(this).css("background", "#ffffff");
			$j(this).css("color", "#666666");
		});
		
		// Autofocus
		//searchField.focus();
	}
});
