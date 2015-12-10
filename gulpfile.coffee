gulp   = require 'gulp'
util   = require 'gulp-util'
concat = require 'gulp-concat'

smaps  = require 'gulp-sourcemaps'
coffee = require 'gulp-coffee'
sass   = require 'gulp-ruby-sass'
haml   = require 'gulp-ruby-haml'
cjsx   = require 'gulp-cjsx'

# 防止编译 coffee 过程中 watch 进程中止
plumber = require("gulp-plumber")

app =
  src:
    base:
      coffee: 'src/base/coffee/*.coffee'
      scss:   'src/base/scss/*.scss'
    usage:
      coffee: 'usage/coffee/*.coffee'
  dist:
    base:
      js:  'dist/base/js'
      css: 'dist/base/css'
    usage:
      js:  'usage/js'

compile_js_concat = (src_path, dist_path, file_name)->
  gulp.src src_path
    .pipe plumber()
    .pipe smaps.init()
    .pipe coffee()
    .pipe concat file_name
    .pipe smaps.write '.'
    .pipe gulp.dest dist_path

gulp.task 'base-js', ->
  compile_js_concat app.src.base.coffee, app.dist.base.js, 'base.js'

gulp.task 'usage-js', ->
  compile_js_concat app.src.usage.coffee, app.dist.usage.js, 'usage.js'

gulp.task 'base-css', ->
  gulp.src app.src.base.scss
    # .pipe sass 'sourcemap=none': true
    .on 'error', (err)->
      file = err.message.match(/^error\s([\w\.]*)\s/)[1]
      util.log [
        err.plugin,
        util.colors.red file
        err.message
      ].join ' '
    .pipe concat 'base.css'
    .pipe gulp.dest app.dist.base.css

# gulp.task 'html', ->
#   gulp.src app.src.html
#     .pipe haml()
#     .pipe gulp.dest(app.dist.html)

gulp.task 'build', [
  'base-js', 'base-css'
  'usage-js'
]

gulp.task 'watch', ['build'], ->
  gulp.watch app.src.base.coffee, ['base-js']
  gulp.watch app.src.base.scss, ['base-css']

  gulp.watch app.src.usage.coffee, ['usage-js']