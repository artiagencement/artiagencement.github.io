module.exports = (grunt) ->
  grunt.initConfig
    pkg: grunt.file.readJSON("package.json")

    # Deal with Jekyll
    exec:
      serve:
        cmd: "jekyll serve"
      build:
        cmd: "jekyll build"

    # Optimize images
    imagemin:
      default:
        options:
          optimizationLevel: 3

        files: [
          expand: true
          src: "img/**/*.{png,jpg,gif}"
        ]

    # Compile SASS files
    sass:
      default:
        options:
          style: "compressed"

        files:
          "css/style.css": "sass/style.scss"
    
    # Watch for file changes (autocompile + Livereload)
    watch:
      img:
        files: ["img/**/*.{png,jpg,gif}"]
        tasks: ["imaginemin"]
        options:
          livereload: true
          nospawn: true

      livereload:
        files: ["css/**/*.css", "_site/**/*"]
        options:
          livereload: true
          nospawn: true

      sass:
        files: ["sass/**/*.scss"]
        tasks: ["sass"]

      jekyll:
        files: ["**/*.html", "!**/_site/**", "_config.yml"]
        tasks: ["exec:build"]

  
  # Load NPM tasks
  grunt.loadNpmTasks "grunt-contrib-imagemin"
  grunt.loadNpmTasks "grunt-contrib-sass"
  grunt.loadNpmTasks "grunt-contrib-watch"
  grunt.loadNpmTasks "grunt-exec"
  
  # Register tasks
  grunt.registerTask "dev", ["watch"]
  grunt.registerTask "server", ["exec:serve"]