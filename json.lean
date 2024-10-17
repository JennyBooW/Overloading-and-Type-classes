-- Let's make JSON

inductive JSON where
  | true   : JSON
  | false  : JSON
  | null   : JSON
  | string : String → JSON
  | number : Float  → JSON
  | object : List (String × JSON) → JSON
  | array  : List JSON → JSON
deriving Repr
