<?php
class Foo_Widget extends WP_Widget {
        public function __construct() {
                parent::__construct(
                        'foo_widget',
                        'Foo_Widget',
                        array('description' => __('A Foo Widget', 'text_domain'))
                );
        }

        public function widget($args, $instance) {
                extract($args);
                $title = apply_filters('widget_title', $instance['title']);

                echo $before_widget;
                if (! empty($title)) {
                        echo $before_title . $title . $after_title;
                }
                echo __('Hello, World!', 'text_domain');
                echo $after_widget;
        }

    /**
     * Back-end widget form.
     *
     * @see WP_Widget::form()
     *
     * @param array $instance Previously saved values from database.
     */
    public function form( $instance ) {
        if ( isset( $instance[ 'title' ] ) ) {
            $title = $instance[ 'title' ];
        }
        else {
            $title = __( 'New title', 'text_domain' );
        }
        ?>
        <p>
            <label for="<?php echo $this->get_field_name( 'title' ); ?>"><?php _e( 'Title:' ); ?></label>
            <input class="widefat" id="<?php echo $this->get_field_id( 'title' ); ?>" name="<?php echo $this->get_field_name( 'title' ); ?>" type="text" value="<?php echo esc_attr( $title ); ?>" />
         </p>
    <?php
    }

    /**
     * Sanitize widget form values as they are saved.
     *
     * @see WP_Widget::update()
     *
     * @param array $new_instance Values just sent to be saved.
     * @param array $old_instance Previously saved values from database.
     *
     * @return array Updated safe values to be saved.
     */
    public function update( $new_instance, $old_instance ) {
        $instance = array();
        $instance['title'] = ( !empty( $new_instance['title'] ) ) ? strip_tags( $new_instance['title'] ) : '';

        return $instance;
    }

}
?>
<?php
function register_foo() {
    register_widget( 'Foo_Widget' );

    register_sidebar( array(
        'name'          => __( 'Footer', 'usai' ),
        'id'            => 'footer',
        'before_widget' => '<aside id="%1$s" class="widget %2$s">',
        'after_widget'  => '</aside>',
        'before_title'  => '<h3 class="widget-title">',
        'after_title'   => '</h3>',
    ) );
}

if (!function_exists('usaitheme_setup')) :
function usaitheme_setup() {
        add_theme_support('widgets');
        // Register Foo_Widget widget
        add_action( 'widgets_init', 'register_foo' );
}
endif;
add_action( 'after_setup_theme', 'usaitheme_setup' );
?>

