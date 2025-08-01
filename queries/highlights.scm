; Punctuation
;------------

[
  "," "." ";" ":" "=" "|" "~" "?" "+" "-" "!" ">" "&"
  "->" ";;" ":>" "+=" ":=" ".."
] @punctuation.delimiter

["(" ")" "[" "]" "{" "}" "[|" "|]" "[<" "[>"] @punctuation.bracket

(object_type ["<" ">"] @punctuation.bracket)

"%" @punctuation.special
".~" @punctuation.special

(attribute ["[@" "]"] @punctuation.special)
(item_attribute ["[@@" "]"] @punctuation.special)
(floating_attribute ["[@@@" "]"] @punctuation.special)
(extension ["[%" "]"] @punctuation.special)
(item_extension ["[%%" "]"] @punctuation.special)
(quoted_extension ["{%" "}"] @punctuation.special)
(quoted_item_extension ["{%%" "}"] @punctuation.special)
(metaocaml_bracket_expression [".<" ">."] @punctuation.special)
(metaocaml_escape_expression [".~(" ")"] @punctuation.special)

; Keywords
;---------

[
  "and" "as" "assert" "begin" "class" "constraint" "do" "done" "downto" "effect"
  "else" "end" "exception" "external" "for" "fun" "function" "functor" "if" "in"
  "include" "inherit" "initializer" "lazy" "let" "match" "method" "module"
  "mutable" "new" "nonrec" "object" "of" "open" "private" "rec" "sig" "struct"
  "then" "to" "try" "type" "val" "virtual" "when" "while" "with"
] @keyword

; Operators
;----------

[
  (prefix_operator)
  (sign_operator)
  (pow_operator)
  (mult_operator)
  (add_operator)
  (concat_operator)
  (rel_operator)
  (and_operator)
  (or_operator)
  (assign_operator)
  (hash_operator)
  (indexing_operator)
  (let_operator)
  (let_and_operator)
  (match_operator)
] @operator

(match_expression (match_operator) @keyword)

(value_definition [(let_operator) (let_and_operator)] @keyword)

["*" "#" "::" "<-"] @operator

; Constants
;----------

(boolean) @constant

[(number) (signed_number)] @number

[(string) (character)] @string

(quoted_string "{" @string "}" @string) @string

(escape_sequence) @escape

(conversion_specification) @string.special

; Variables
;----------

[(value_name) (type_variable)] @variable

(value_pattern) @variable.parameter

; Properties
;-----------

[(label_name) (field_name) (instance_variable_name)] @property

; Functions
;----------

(let_binding
  pattern: (value_name) @function
  (parameter))

(let_binding
  pattern: (value_name) @function
  body: [(fun_expression) (function_expression)])

(value_specification (value_name) @function)

(external (value_name) @function)

(method_name) @function.method

(application_expression
  function: (value_path (value_name) @function))

(infix_expression
  left: (value_path (value_name) @function)
  operator: (concat_operator) @operator
  (#eq? @operator "@@"))

(infix_expression
  operator: (rel_operator) @operator
  right: (value_path (value_name) @function)
  (#eq? @operator "|>"))

(
  (value_name) @function.builtin
  (#match? @function.builtin "^(raise(_notrace)?|failwith|invalid_arg)$")
)

; Types
;------

[(class_name) (class_type_name) (type_constructor)] @type

(
  (type_constructor) @type.builtin
  (#match? @type.builtin "^(int|char|bytes|string|float|bool|unit|exn|array|list|option|int32|int64|nativeint|format6|lazy_t)$")
)

[(constructor_name) (tag)] @constructor

; Modules
;--------

[(module_name) (module_type_name)] @module

; Attributes
;-----------

(attribute_id) @tag

; Comments
;---------

[(comment) (line_number_directive) (directive) (shebang)] @comment
