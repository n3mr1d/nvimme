; Inject PHP syntax inside @php ... @endphp
((directive
  (directive_name) @name (#eq? @name "php")
  (directive_arguments) @php)
 (#set! injection.language "php"))

; Inject PHP inside Blade directives with expressions
((directive
  (directive_name) @name
  (directive_arguments) @args
  (#match? @name "if|elseif|foreach|for|while|switch|case"))
 (#set! injection.language "php"))
