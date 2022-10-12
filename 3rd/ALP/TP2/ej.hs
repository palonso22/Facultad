leaf =  \ l b -> l
bin = \ a t u l b -> b a (t l b) (u l b)
isLeaf = 
