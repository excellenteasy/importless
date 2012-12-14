'use strict';

module.exports = function(grunt) {

  grunt.loadNpmTasks('grunt-contrib-nodeunit');

  // Project configuration.
  grunt.initConfig({
    pkg: '<json:package.json>',
    nodeunit: {
      all: ['test/**/*.coffee']
    },
    lint: {
      files: ['Gruntfile.js', 'lib/**/*.js', 'test/**/*.js']
    },
    watch: {
      files: '<config:lint.files>',
      tasks: 'default'
    },
    jshint: {
      options: {
        curly: true,
        eqeqeq: true,
        immed: true,
        latedef: true,
        newcap: true,
        noarg: true,
        sub: true,
        undef: true,
        boss: true,
        eqnull: true,
        node: true
      },
      globals: {
        exports: true
      }
    }
  });

  // Default task.
  grunt.registerTask('default', 'test');

  grunt.registerTask('test', 'nodeunit');

};