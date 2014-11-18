module.exports = function (grunt) {
  'use strict';

  // Load Grunt tasks declared in the package.json file
  require('load-grunt-tasks')(grunt, {
    pattern: ['grunt-*']
  });

  grunt.initConfig({
    scsslint: {
      allFiles: [
        'app/assets/stylesheets/**/*.scss',
      ],
      options: {
        config: '.scss-lint.yml'
      }
    }
  });

  grunt.registerTask('default', ['scsslint']);
};
