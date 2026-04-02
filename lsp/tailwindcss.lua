return {
  cmd = { 'tailwindcss-language-server', '--stdio' },
  filetypes = { 'html', 'css', 'scss', 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'vue' },
  root_markers = {
    'tailwind.config.js',
    'tailwind.config.cjs',
    'tailwind.config.ts',
    'postcss.config.js',
    'postcss.config.ts',
  },
  settings = {
    scss = { validate = false },
    editor = { quickSuggestions = { strings = true }, autoClosingQuotes = 'always' },
    tailwindCSS = {
      experimental = {
        classRegex = {
          [[[\S]*ClassName="([^"]*)]], -- <MyComponent containerClassName="..." />
          [[[\S]*ClassName={"([^"}]*)]], -- <MyComponent containerClassName={"..."} />
          [[[\S]*ClassName={"([^'}]*)]], -- <MyComponent containerClassName={'...'} />
        },
      },
      includeLanguages = {
        typescript = 'javascript',
        typescriptreact = 'javascript',
      },
    },
  },
}
