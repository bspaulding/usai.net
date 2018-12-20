<!DOCTYPE html>
<html <?php language_attributes(); ?>>
<head>
<meta charset="<?php bloginfo( 'charset' ); ?>">
<link rel="shortcut icon" href="<?php echo get_bloginfo('template_directory'); ?>/images/favicon.ico">
<link rel="stylesheet" href="<?php echo get_bloginfo('template_directory'); ?>/master.css">
<!--[if IE]>
<style type="text/css">
#nav_global ul li A:hover {
	height: 100%;
}
</style>
<![endif]-->
<meta name="google-site-verification" content="d90jOrhHiJFaNbCEaxoj0ORVRfh7J1nxx2-kDkR_v_4" />
<?php wp_head(); ?>
</head>

<body <?php body_class(); ?>>

<div id="wrap">
	<div id="header">
		<?php get_search_form() ?>
		<a href="">
			<img src="<?php echo get_bloginfo('template_directory'); ?>/images/logo.png"/>
		</a>
	</div>

	<div id="nav_global">
		<?php get_template_part('global_nav') ?>
	</div>
