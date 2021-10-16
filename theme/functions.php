<?php
if (!function_exists('usaitheme_setup')) :
function usaitheme_setup() {
    register_sidebar( array(
        'name'          => __( 'Footer', 'usai' ),
        'id'            => 'footer',
        'before_widget' => '<aside id="%1$s" class="widget %2$s">',
        'after_widget'  => '</aside>',
        'before_title'  => '<h3 class="widget-title">',
        'after_title'   => '</h3>',
    ) );
}
endif;
add_action( 'after_setup_theme', 'usaitheme_setup' );
?>

