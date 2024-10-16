def words : List String :=
  ["Hello", "World", "!"]

-- Array is like std::vector
def trees : Array String :=
  #["oak", "elm", "birch", "sole"]

#eval trees
#eval trees[1]

-- Non-Empty List
structure NonEmptyList (α : Type) : Type where
  head : α
  tail : List α
deriving Repr

def spiders : NonEmptyList String := {
  head := "Giga spider Yikes"
  tail := [
    "Sac   spider",
    "Wolf  spider",
    "Hobo  spider",
    "Nasty spider",
    "Icky  spider",
    "Cat-faced spider" -- Huh?
  ]
}

-- Look-up value at specific index
def NonEmptyList.get? : NonEmptyList α → Nat → Option α
  | xs, 0     => some xs.head
  | xs, n + 1 => xs.tail.get? n

#eval spiders.get? 1

-- tactic for cheching if index is inbounds
abbrev NonEmptyList.inBounds (xs : NonEmptyList α) (index : Nat) : Prop :=
  index <= xs.tail.length

theorem isTenthSpiderPresent   : spiders.inBounds 10 := by simp
theorem noSeventhSpiderPresent : ¬spiders.inBounds 7 := by simp

-- Non optional .get
def NonEmptyList.get (xs : NonEmptyList α) (index : Nat) (ok : xs.inBounds index) : α :=
  match index with
  | 0     => xs.head
  | n + 1 => xs.tail[n]

-- get element with []

instance : GetElem (NonEmptyList α) Nat α NonEmptyList.inBounds where
  getElem := NonEmptyList.get

#eval spiders[1]

-- Appending operation ++
-- Homo
instance : Append (NonEmptyList α) where
  append xs ys := { head := xs.head, tail := xs.tail ++ ys.head :: ys.tail }

-- Hetero
instance : HAppend (NonEmptyList α) (List α) (NonEmptyList α) where
  hAppend xs ys := { head := xs.head, tail := xs.tail ++ ys }


#eval spiders ++ spiders
#eval spiders ++ [ "Super nasty spider with giant hairy legs" ]

-- Functors

#eval Functor.map (· + 5) [1, 2, 3]
#eval Functor.map List.reverse [[1, 2, 3], [4, 5, 6]]

-- Functor is a long name so LEAN has <$>
#eval (· + 5) <$> [1, 2, 3]

-- Instance of Functor for NonEmptyList
instance : Functor NonEmptyList where
  map f xs := { head := f xs.head, tail := f <$> xs.tail }

#eval (· ++ " nasty") <$> spiders

-- Exercises
-- Write an instance of HAppend (List α) (NonEmptyList α) (NonEmptyList α) and test it.
-- Implement a Functor instance for the binary tree datatype.

instance : HAppend (List α) (NonEmptyList α) (NonEmptyList α) where
  hAppend xs ys := { head := ys.head, tail := xs ++ ys.tail }

-- testing
#eval ["Giga icky spider long legs"] ++ spiders


-- Binary Tree

inductive BiTree (α : Type)
  | Leaf : BiTree α
  | Node : α → BiTree α → BiTree α → BiTree α

-- Doesn't work huh ?

-- List sum

def sumListStr : List String → String
  | []      => ""
  | x :: xs => x ++ sumListStr xs

#eval sumListStr ["Hello", " World!", " It works?"]
