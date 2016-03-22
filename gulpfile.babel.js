import gulp from 'gulp';
import gulpLoadPlugins from 'gulp-load-plugins';

const $ = gulpLoadPlugins();

const paths = {
  "scripts": [
    'javascripts/libs/*.js',
    'javascripts/*.js',
    '!javascripts/pinboard.js',
    '!javascripts/twitter.js',
  ],
  "images": 'photos/**/*'
};

gulp.task('minify-js', () => {
  return gulp.src(paths.scripts)
    .pipe($.plumber())
    .pipe($.sourcemaps.init())
    .pipe($.babel())
    .pipe($.concat('dist.min.js'))
    .pipe($.uglify())
    .pipe($.sourcemaps.write('.'))
    .pipe(gulp.dest('source/javascripts'));
});

gulp.task('images', () => {
  return gulp.src(paths.images)
    .pipe($.cache($.imagemin({
      progressive: true,
      interlaced: true,
      svgoPlugins: [{cleanupIDs: false}]
    })))
    .pipe(gulp.dest('source/photos'));
});

gulp.task('watch', () => {
  gulp.watch(paths.scripts, ['minify-js']);
  gulp.watch(paths.images, ['images']);
});

gulp.task('default', ['minify-js', 'images'], () => {
  return gulp.src('public/**/*')
    .pipe($.size({title: 'default', gzip: true}));
});
