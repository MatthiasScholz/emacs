(configuration-layer/declare-layer
 '(
   javascript
   typescript
   ;; FIXME Not working - how to configure layer variables?
   ;; (javascript :variables
   ;;             ;; Helper
   ;;             javascript-import-tool 'import-js
   ;;             ;; TODO Add support for lsp
   ;;             javascript-backend 'tern
   ;;             ;; Formatter
   ;;             javascript-fmt-on-save t
   ;;             javascript-fmt-tool 'prettier
   ;;             ;; Linter
   ;;             javascript-linter 'eslint
   ;;             javascript-lsp-linter nil
   ;;             js2-mode-show-strict-warnings nil
   ;;             ;; Add node_modules/.bin to exec_path
   ;;             node-add-modules-path t
   ;;             )
   ;; (typescript :variables
   ;;             ;; Helper
   ;;             ;; TODO Add support for lsp
   ;;             typescript-backend 'tern
   ;;             ;; Formatter
   ;;             typescript-fmt-on-save t
   ;;             typescript-fmt-tool 'prettier
   ;;             ;; Linter
   ;;             typescript-linter 'eslint
   ;;             )
   )
 )
