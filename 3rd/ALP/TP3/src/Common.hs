module Common where

  -- Comandos interactivos o de archivos
  data Stmt i = Def String i           --  Declarar un nuevo identificador x, let x = t
              | Eval i                 --  Evaluar el término
    deriving (Show)

  instance Functor Stmt where
    fmap f (Def s i) = Def s (f i)
    fmap f (Eval i)  = Eval (f i)

  -- Tipos de los nombres
  data Name
     =  Global  String
    deriving (Show, Eq)

  -- Entornos
  type NameEnv v t = [(Name, (v, t))]

  -- Tipo de los tipos
  data Type = Base
            | Fun Type Type
            | Unit
            | PairType Type Type
            | Nat
            deriving (Show, Eq)

  -- Términos con nombres
  data LamTerm  =  LVar String
                |  Abs String Type LamTerm
                |  App LamTerm LamTerm
                |  LetL String LamTerm LamTerm
                |  AsL LamTerm Type
                | UnitL
                | PairL LamTerm LamTerm
                | FstL LamTerm
                | SndL LamTerm
                | ZeroL
                | SucL LamTerm
                | RecL LamTerm LamTerm LamTerm
                deriving (Show, Eq)


  -- Términos localmente sin nombres
  data Term  = Bound Int
             | Free Name
             | Term :@: Term
             | Lam Type Term
             | LetT String Term Term
             | AsT Term Type
             | UnitT
             | PairT Term Term
             | FstT Term
             | SndT Term
             | ZeroT
             | SucT Term
             | RecT Term Term Term
          deriving (Show, Eq)

  -- Valores
  data Value = VLam Type Term
             | VUnit
             | VPair Value Value
             | VNv Nv

  data Nv = Zero | Suc Nv



  -- Contextos del tipado
  type Context = [Type]
