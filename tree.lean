-- Forestry appliction
structure Tree : Type where
  latinName   : String
  commonNames : List String
deriving Repr

def oak : Tree :=
  ⟨ "Quercus robur", [ "common oak", "European oak" ] ⟩

def birch : Tree := {
  latinName   := "Betula pendula",
  commonNames := [ "silver birch", "warty birch" ]
  }

def sloe : Tree where
  latinName   := "Prunus spinosa"
  commonNames := [ "sloe", "blackthorn" ]

-- All three syntaxes are equivalent.

-- Now for type class instances.
class Display (α : Type) where
  displayName : α → String

instance : Display Tree :=
  ⟨ Tree.latinName ⟩

instance : Display Tree :=
  { displayName := Tree.latinName }

instance : Display Tree where
  displayName := Tree.latinName

-- And again all three are equal.

-- Examples, it is like a definition without a name.
example (n : Nat) (k : Nat) : Bool :=
  n + k == k + n
