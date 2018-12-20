<?php get_header(); ?>
	<div id="main">

	<?php
		if (have_posts()) :
			/* Start the Loop */
			while (have_posts()) : the_post();
				get_template_part('content', get_post_format());
			endwhile;
			/* End the Loop */
		else :
			// Nothing
		endif;
	?>
	</div>
<?php get_footer(); ?>
