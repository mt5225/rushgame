module.exports = (grunt) ->
  grunt.initConfig
    coffee:
      all:
        files: [{
          expand: true
          cwd: 'src/'
          src: '**/*.coffee'
          dest: 'js'
          ext: '.js'
        }]
        options:
          bare: true
          spawn: false

    coffeelint:
      options:
        force: true
      all:
        expand: true
        cwd: 'src/'
        src: '**/*.coffee'

    watch:
      coffeescript:
        files: ['src/*.coffee']
        tasks: ['newer:coffee']

    connect:
      server:
        port: 80
        base: '.'
        options:
          keepalive: true

  grunt.loadNpmTasks 'grunt-coffeelint'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-newer'
  grunt.loadNpmTasks 'grunt-connect'

  grunt.registerTask 'default', ['coffeelint:all', 'coffee:all', 'watch']
