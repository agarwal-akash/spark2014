with Ada.Text_IO;
use Ada.Text_IO;



procedure borrowingcomposite with SPARK_Mode is

  type Int_Ptr is access integer;
  type Rec is record
	X, Y : Int_Ptr;
  end record;
  
 procedure Swap_Rec (R : in out Rec) is -- R1 is borrowed
  begin
     Swap (R.X, R.Y);
     Swap_Content (R.X, R.Y); 
  end Swap_Rec;

  R1 : Rec;
  begin
	Swap_Rec (R1);
	(...);
  end borrowingcomposite;
	
