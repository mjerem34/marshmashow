exports.config = {
  files: {
    javascripts: {
      joinTo: "js/app.js"
    },
    stylesheets: {
        joinTo: "css/app.css",
        order: {
          before: ["css/_vars.scss", "css/*.scss"],
          after: ["css/app.scss"] // concat app.css last
        }
    },
    templates: {
      joinTo: "js/app.js"
    }
  },

  conventions: {
    assets:
    [
      /^(static)/,
      /^(node_modules\/font-awesome)/
    ]
  },
  paths: {
    watched: [
      "static",
      "css",
      "js",
      "vendor",
      "node_modules/font-awesome/fonts/fontawesome-webfont.eot",
      "node_modules/font-awesome/fonts/fontawesome-webfont.svg",
      "node_modules/font-awesome/fonts/fontawesome-webfont.ttf",
      "node_modules/font-awesome/fonts/fontawesome-webfont.woff",
      "node_modules/font-awesome/fonts/fontawesome-webfont.woff2"
    ],
    public: "../priv/static"
  },
  plugins: {
     babel: {
       ignore: [/vendor/]
     },
     copycat: {
      //  "fonts": ["node_modules/bootstrap-sass/fonts/bootstrap"] // copy node_modules/bootstrap-sass/fonts/bootstrap/* to priv/static/fonts/
     },
     sass: {
       options: {
         includePaths: ["node_modules/bootstrap-sass/stylesheets"], // tell sass-brunch where to look for files to @import
         precision: 8 // minimum precision required by bootstrap-sass
       }
     }
   },
  modules: {
    autoRequire: {
      "js/app.js": ["app"]
    }
  },
  npm: {
    enabled: true,
    globals: { // bootstrap-sass' JavaScript requires both '$' and 'jQuery' in global scope
      $: 'jquery',
      jQuery: 'jquery',
      bootstrap: 'bootstrap-sass' // require bootstrap-sass' JavaScript globally
    }
  }
};
