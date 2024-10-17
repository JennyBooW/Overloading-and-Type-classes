-- Coercions
-- A way to convert one type to another

-- class Coe (α : Type) (β : Type) where
--   coe : α → β

-- Coercion of type Int to Nat
instance : Coe Int Nat where
  coe x := x.toNat

#eval ((10 : Int) : Nat)


-- Coercions can be chained.
-- Example
inductive A where
  | a
deriving Repr

inductive B where
  | b
deriving Repr

instance : Coe A B where
  coe _ := B.b

instance : Coe B A where
  coe _ := A.a

instance : Coe Unit A where
  coe _ := A.a


-- Empty () is Unit type
-- because B is present in coercions
-- B can be converted to A
def coercedToB : B := ()

#eval coercedToB

-- Option type is similiar to Kotlin Optional type.
-- val word : String? = null

def List.last? : List α → Option α
  | []  => none
  | [x] => some x
  | _ :: x :: xs => last? (x :: xs)

-- This doesnt work
-- def maybeMaybe : (Option (Option (Option Nat))) :=
--   392

def maybeMaybe : (Option (Option (Option Nat))) :=
  (392 : Nat)

-- or This
def maybeMaybeHuh : (Option (Option (Option Nat))) :=
  ↑(392 : Nat)
