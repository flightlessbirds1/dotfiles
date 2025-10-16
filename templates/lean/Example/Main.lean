inductive myNat where
| zero : myNat
| succ : myNat → myNat


inductive myList where
| nil : myList
| cons : myNat → myList → myList


theorem myLemma : ∀ n, myNat.zero ≠ myNat.succ n
:= fun n => by
  intro h
  cases h


inductive myEq : myNat → myNat → Prop where
| refl : (x : myNat) → myEq x x


#check myEq.refl
#check (myEq.refl myNat.zero)


theorem zeroequalszero : myEq myNat.zero myNat.zero
:= by
  apply myEq.refl


def myone : myNat
 := myNat.succ myNat.zero


theorem inters : (myEq myNat.zero myNat.zero) ∧ myEq myone myone
  := And.intro (zeroequalszero) (myEq.refl myone)

inductive myOr : Prop → Prop → Prop where
| ProofA { a b : Prop } (disjunct1 : a) : myOr a b
| ProofB { a b : Prop } (disjunct2 : b) : myOr a b
#check myOr.ProofA

def xy : myOr (1 = 1) (0 = 0)
  := by
    apply myOr.ProofA
    apply Eq.refl
