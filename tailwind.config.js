module.exports = {
  content: [
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/javascript/**/*.js'
  ],
  theme: {
    extend: {
      colors: {
        'BaseGreen': {
          '50': '#ecfdf5',
          '100': '#d2f9e4',
          '200': '#a9f1cf',
          '300': '#71e4b4',
          '400': '#39ce95',
          '500': '#15b47c',
          '600': '#099265',
          '700': '#087f5b',
          '800': '#095c44',
          '900': '#084c39',
          '950': '#032b20',
      },
      },
      spacing: {
        'bigCard': '28.2rem'
      },
    },
  },
  plugins: [],
}
