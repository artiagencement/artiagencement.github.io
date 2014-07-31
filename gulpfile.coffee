csso = require 'gulp-csso'
gulp = require 'gulp'
coffee = require 'gulp-coffee'
livereload = require 'gulp-livereload'
stylus = require 'gulp-stylus'

gulp.task 'stylus', ->
  gulp.src './assets/styl/style.styl'
    .pipe stylus()
    .pipe csso()
    .pipe gulp.dest './css'

gulp.task 'coffee', ->
  gulp.src './assets/coffee/**/*.coffee'
    .pipe coffee()
    .pipe gulp.dest './js'

gulp.task 'default', ['stylus', 'coffee'], () ->
  livereload.listen();
  stylusWatcher = gulp.watch './assets/styl/**/*.styl', ['stylus']
  stylusWatcher.on 'change', (event) ->
    console.log event.path + ' was ' + event.type + ', running Stylus...'

  cssWatcher = gulp.watch './css/**/*.css'
  cssWatcher.on 'change', livereload.changed

  coffeeWatcher = gulp.watch './assets/coffee/**/*.coffee', ['coffee']
  coffeeWatcher.on 'change', (event) ->
    console.log event.path + ' was ' + event.type + ', running CoffeeScript...'

  jsWatcher = gulp.watch './js/**/*.js'
  jsWatcher.on 'change', livereload.changed