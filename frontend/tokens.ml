
type token = 
  | T_Add
  | T_Div
  | T_Int of string
  | T_Float of string
  | T_Id of string
  | T_If
  | T_Else
  | T_For
  | T_Fun
  | T_LBrack 
  | T_RBrack
  | T_LBrace
  | T_RBrace
  | T_LParan
  | T_RParan
  | T_SemiColon
  | T_TInt
  | T_TDouble
  | T_TString
  | T_Const
  | T_Var
[@@deriving show]