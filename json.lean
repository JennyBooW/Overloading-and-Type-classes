import Lean

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

-- JSON serializer is a structure that tracks the type it knows how to serialize
-- along with the serialization code itself.
structure Serializer where
  Contents   : Type
  serializer : Contents → JSON

-- A serializer for strings need only wrap the provided string in the JSON.string constructor
def Str : Serializer := {
  Contents   := String,
  serializer := JSON.string
}

-- Viewing JSON serializers as functions that serialize their argument requires extracting
-- the inner type of serializable data.
instance : CoeFun Serializer (λ s => s.Contents → JSON) where
  coe s  := s.serializer

-- Given this instance, a serializer can be applied directly to an argument.
def buildRepsonse (title : String) (R : Serializer) (record : R.Contents) : JSON :=
  JSON.object [
    ("title", JSON.string title),
    ("status", JSON.number 200 ),
    ("record", R record)
  ]

#eval buildRepsonse "Funcitonal Programming in Lean" Str "Programming is fun!"

-- function to drop decimals, as JSON doesnt distinguish between Floats and Integers
def dropDecimals (numString : String) : String :=
  if numString.contains '.' then
    let noTrailingZeroes := numString.dropRightWhile (· == '0')
    noTrailingZeroes.dropRightWhile (· == '.')
  else numString

#eval dropDecimals "10.1"

-- Append the list of strings with a separator in between them.
def String.separate (sep : String) (strings : List String) : String :=
  match strings with
  | [] => ""
  | x :: xs => String.join (x :: xs.map (sep ++ ·))

-- Testing...
#eval String.separate "-" ["Hello", "World"]
