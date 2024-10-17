-- Monoid
structure Monoid where
  Carrier : Type
  neutral : Carrier
  op      : Carrier → Carrier → Carrier
deriving Repr

-- Monoid over Natural with Mul
def natMulMonoid : Monoid :=
  { Carrier := Nat, neutral := 1, op := (· * ·) }

-- Monoid over Natural with Add
def natAddMonoid : Monoid :=
  { Carrier := Nat, neutral := 0, op := (· * ·) }

-- Monoid over String with Append
def stringMonoid : Monoid :=
  { Carrier := String, neutral := "", op := String.append }

-- Monoid over List with Append
def listMonoid (α : Type) : Monoid :=
  { Carrier := List α, neutral := [], op := List.append }

-- Coercion into Carrier Set
instance : CoeSort Monoid Type where
  coe m := m.Carrier

-- Fold Map
def foldMap (M : Monoid) (f : α → M.Carrier) (xs : List α) : M :=
  let rec go (soFar : M) : List α → M
    | [] => soFar
    | y :: ys => go (M.op soFar (f y)) ys
  go M.neutral xs

instance : CoeSort Bool Prop where
  coe b := b = true

-- Function coercion
-- class CoeFun (α : Type) (makeFunctionType : outParam (α → Type)) where
--   coe : (x : α) → makeFunctionType x

structure Adder where
  howMuch : Nat

instance : CoeFun Adder (fun _ => Nat → Nat) where
  coe a := (· + a.howMuch)

def add10 : Adder := ⟨10⟩

#eval add10 20
