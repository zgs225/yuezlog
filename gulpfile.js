var gulp       = require('gulp');
var concat     = require('gulp-concat');
var uglify     = require('gulp-uglify');
var sourcemaps = require('gulp-sourcemaps');

var paths = {
  scripts: ['javascripts/libs/*.js',
            'javascripts/*.js',
            '!javascripts/pinboard.js',
            '!javascripts/twitter.js'],
};

// Minify and concat javascript
gulp.task('minify-js', function () {
  return gulp.src(paths.scripts)
             .pipe(sourcemaps.init())
             .pipe(uglify())
             .pipe(concat('dist.min.js'))
             .pipe(sourcemaps.write())
             .pipe(gulp.dest('source/javascripts'));
});

gulp.task('default', ['minify-js']);
