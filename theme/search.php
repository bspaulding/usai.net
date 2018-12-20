<?php get_header(); ?>
	<div id="main">
	<h1>Search Results for '<span id="query" style="font-style:italic;"><?php printf(get_search_query()); ?></span>'</h1>

	<div id="search_results">
	<ul>
	<?php
		if (have_posts()) :
			/* Start the Loop */
			while (have_posts()) : the_post();
				get_template_part('content-search-result', get_post_format());
			endwhile;
			/* End the Loop */
		else :
			// Nothing
		endif;
	?>
	</ul>
	</div>
	</div>
<?php get_footer(); ?>
