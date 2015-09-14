var elixir = require('laravel-elixir');

require('laravel-elixir-imagemin');

/*
 |--------------------------------------------------------------------------
 | Elixir Asset Management
 |--------------------------------------------------------------------------
 |
 | Elixir provides a clean, fluent API for defining some basic Gulp tasks
 | for your Laravel application. By default, we are compiling the Sass
 | file for our application, as well as publishing vendor resources.
 |
 */

elixir(function(mix) {
    mix.less(
            'main.less',
            'public/css/main.css'
        )
        .copy(
            'resources/assets/fonts',
            'public/fonts'
        )
        .copy(
            'resources/assets/img',
            'public/img'
        )
        .imagemin("./public/img")
        .copy(
            'vendor/bower_components/jquery/index.js',
            'resources/assets/js/vendor/jquery.js'
        )
        .scripts([
            'vendor/**/*.js',
            '**/*.js'
        ]);
});
