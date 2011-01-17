------------------------------------------------------------------------------
--                                                                          --
--                            GNAT2WHY COMPONENTS                           --
--                                                                          --
--                   G N A T 2 W H Y - S U B P R O G R A M S                --
--                                                                          --
--                                 S p e c                                  --
--                                                                          --
--                       Copyright (C) 2010-2011, AdaCore                   --
--                                                                          --
-- gnat2why is  free  software;  you can redistribute it and/or modify it   --
-- under terms of the  GNU General Public License as published  by the Free --
-- Software Foundation;  either version  2,  or  (at your option) any later --
-- version. gnat2why is distributed in the hope that it will  be  useful,   --
-- but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHAN-  --
-- TABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public --
-- License  for more details. You  should  have  received a copy of the GNU --
-- General Public License  distributed with GNAT; see file COPYING. If not, --
-- write to the Free Software Foundation,  51 Franklin Street, Fifth Floor, --
-- Boston,                                                                  --
--                                                                          --
-- gnat2why is maintained by AdaCore (http://www.adacore.com)               --
--                                                                          --
------------------------------------------------------------------------------

with Types;      use Types;
with Why.Ids;    use Why.Ids;

package Gnat2Why.Subprograms is

   --  This package deals with the translation of GNAT expressions and
   --  statements to Why expressions.
   --
   --  In Why, there is no distinction between expressions and statements; a
   --  statement is simply an expression that has the return type "unit".
   --
   --  More specific documentation is given at the beginning of each function
   --  in this package.

   function Why_Expr_of_Ada_Expr (Expr : Node_Id) return W_Prog_Id;
   --  Translate a single Ada expression into a Why expression
   --
   --  The translation is pretty direct for many constructs. We list the ones
   --  here for which there is something else to do.
   --  * Read access: We need to add a dereferencing operator in Why

   function Why_Expr_of_Ada_Stmt (Stmt : Node_Id) return W_Prog_Id;
   --  Translate a single Ada statement into a Why expression

   function Why_Expr_of_Ada_Stmts (Stmts : List_Id) return W_Prog_Id;
   --  Translate a list of Ada statements into a single Why expression
   --  An empty list is translated to "void"

   procedure Why_Decl_of_Ada_Subprogram
     (File : W_File_Id;
      Node : Node_Id);
   --  Generate a Why declaration that corresponds to an Ada subprogram
   --
   --  Care must be taken in a few cases:
   --  * We need to add an argument of type "unit" if the Ada subprogram has
   --    no parameters
   --  * The types of arguments have to be references
   --  * The pre/postconditions need special treatment (TCC)

end Gnat2Why.Subprograms;
