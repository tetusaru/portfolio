module.exports = {
  content: [
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/javascript/**/*.js',
  ],
  safelist: [
    'min-h-[80px]',
    'min-h-[120px]',
    'py-16',
    'py-8',
    'px-4',
    'bg-blue-500',
    'bg-red-500',
    'bg-yellow-500',
    'text-white',
    'flex',
    'justify-between',
    'items-center',
  ],
  theme: {
    extend: {},
  },
  plugins: [],
}