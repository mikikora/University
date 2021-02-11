import qualified QBF as QBF
import qualified NestedQBF as NestedQBF

scopeCheck ::
  (QBF.Var -> Maybe v) -> QBF.Formula -> Maybe (NestedQBF.Formula v)

scopeCheck _ QBF.Bot = pure NestedQBF.Bot
scopeCheck fv (QBF.Not f) = NestedQBF.Not <$> (scopeCheck fv f)
scopeCheck fv (QBF.And f1 f2) = (NestedQBF.And <$> (scopeCheck fv f1)) <*> (scopeCheck fv f2)
scopeCheck fv (QBF.Var p) = NestedQBF.Var <$> (fv p)
scopeCheck fv (QBF.All p f) = NestedQBF.All <$> (scopeCheck (\x ->
                                                               if x == p
                                                               then pure NestedQBF.Z
                                                               else NestedQBF.S <$> (fv x))
                                                  f)
                              
