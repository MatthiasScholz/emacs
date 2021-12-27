(configuration-layer/declare-layer
 '(
        (python :variables
             python-test-runner 'pytest  ;; nose is deprecated
             python-format-on-save t)    ;; FIXME not working
        flycheck
   )
 )
