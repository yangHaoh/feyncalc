(* ::Package:: *)

(* :Title: ValidateModelEulerHeisenberg									*)

(*
	This software is covered by the GNU General Public License 3.
	Copyright (C) 1990-2019 Rolf Mertig
	Copyright (C) 1997-2019 Frederik Orellana
	Copyright (C) 2014-2019 Vladyslav Shtabovenko
*)

(* :Summary:  Validates FeynArts model for the Euler-Heisenberg Lagrangian *)

(* ------------------------------------------------------------------------ *)



(* ::Section:: *)
(*Load FeynCalc and FeynArts*)


If[ $FrontEnd === Null,
		$FeynCalcStartupMessages = False;
		Print["Validation of the FeynArts model for the Euler-Heisenberg Lagrangian"];
];
If[$Notebooks === False, $FeynCalcStartupMessages = False];
$LoadAddOns={"FeynArtsLoader"};
<<FeynCalc`
$FAVerbose = 0;

If[!MatchQ[ToExpression[StringSplit[$FeynCalcVersion, "."]],{a_/;a>=9,b_/;b>=3,_}],
	If[ ($FrontEnd === Null||$Notebooks===False),
	Print["Your FeynCalc version is too old. \
This example requires at least FeynCalc 9.3!"];
	Quit[],
	CreateDialog[{TextCell["Your FeynCalc version is too old. \
This example requires at least FeynCalc 9.3!"],DefaultButton[]},
	Modal->True];
	]
];


(* ::Section:: *)
(*Patch the generated models to work with FeynCalc*)


FAPatch[PatchModelsOnly->True];


(* ::Section:: *)
(*Check vertices*)


diag=InsertFields[CreateTopologies[0,2 -> 2],{V[1],V[1]} -> {V[1],V[1]},
InsertionLevel -> {Classes},Model -> FileNameJoin[{"EulerHeisenberg","EulerHeisenberg"}],
GenericModel->FileNameJoin[{"EulerHeisenberg","EulerHeisenberg"}]];


amp=FCFAConvert[CreateFeynAmp[diag, Truncated -> True,PreFactor->1],
IncomingMomenta->{p1,p2},OutgoingMomenta->{p2,p3},UndoChiralSplittings->True,
DropSumOver->True, List->False,SMP->True];


c1Part=1/SMP["m_e"]^4 32 I c1 (FV[p1,Lor2] FV[p2,Lor1] FV[p2,Lor4] FV[p3,Lor3]-
FV[p2,Lor4] FV[p3,Lor3] MT[Lor1,Lor2] SP[p1,p2]-FV[p2,Lor4] FV[p3,Lor2] MT[Lor1,Lor3] SP[p1,p2]-
FV[p2,Lor2] FV[p2,Lor3] MT[Lor1,Lor4] SP[p1,p3]+MT[Lor1,Lor4] MT[Lor2,Lor3] SP[p1,p3] SP[p2,p2]+
FV[p1,Lor4] FV[p3,Lor1] (FV[p2,Lor2] FV[p2,Lor3]-MT[Lor2,Lor3] SP[p2,p2])-
FV[p1,Lor2] FV[p2,Lor1] MT[Lor3,Lor4] SP[p2,p3]+MT[Lor1,Lor3] MT[Lor2,Lor4] SP[p1,p2] SP[p2,p3]+
MT[Lor1,Lor2] MT[Lor3,Lor4] SP[p1,p2] SP[p2,p3]+FV[p1,Lor3] FV[p2,Lor1] (FV[p2,Lor4] FV[p3,Lor2]-MT[Lor2,Lor4] SP[p2,p3]));


c2Part=1/SMP["m_e"]^4 8 I c2 (-FV[p2,Lor4] FV[p3,Lor3] MT[Lor1,Lor2] SP[p1,p2]-
FV[p2,Lor4] FV[p3,Lor2] MT[Lor1,Lor3] SP[p1,p2]-FV[p2,Lor3] FV[p3,Lor2] MT[Lor1,Lor4] SP[p1,p2]-
FV[p2,Lor2] FV[p3,Lor3] MT[Lor1,Lor4] SP[p1,p2]-FV[p2,Lor3] FV[p2,Lor4] MT[Lor1,Lor2] SP[p1,p3]-
FV[p2,Lor2] FV[p2,Lor4] MT[Lor1,Lor3] SP[p1,p3]-FV[p1,Lor4] FV[p3,Lor3] MT[Lor1,Lor2] SP[p2,p2]-
FV[p1,Lor4] FV[p3,Lor2] MT[Lor1,Lor3] SP[p2,p2]+FV[p1,Lor3] FV[p3,Lor2] MT[Lor1,Lor4] SP[p2,p2]+
FV[p1,Lor2] FV[p3,Lor3] MT[Lor1,Lor4] SP[p2,p2]+MT[Lor1,Lor3] MT[Lor2,Lor4] SP[p1,p3] SP[p2,p2]+
MT[Lor1,Lor2] MT[Lor3,Lor4] SP[p1,p3] SP[p2,p2]+FV[p3,Lor1] (-2 FV[p2,Lor4] MT[Lor2,Lor3] SP[p1,p2]
+FV[p2,Lor3] MT[Lor2,Lor4] SP[p1,p2]+FV[p2,Lor2] (FV[p1,Lor3] FV[p2,Lor4]+MT[Lor3,Lor4] SP[p1,p2])-
FV[p1,Lor3] MT[Lor2,Lor4] SP[p2,p2]+FV[p1,Lor2] (FV[p2,Lor3] FV[p2,Lor4]-MT[Lor3,Lor4] SP[p2,p2]))+
FV[p1,Lor4] FV[p2,Lor3] MT[Lor1,Lor2] SP[p2,p3]+FV[p1,Lor4] FV[p2,Lor2] MT[Lor1,Lor3] SP[p2,p3]-
FV[p1,Lor3] FV[p2,Lor2] MT[Lor1,Lor4] SP[p2,p3]-FV[p1,Lor2] FV[p2,Lor3] MT[Lor1,Lor4] SP[p2,p3]+
2 MT[Lor1,Lor4] MT[Lor2,Lor3] SP[p1,p2] SP[p2,p3]+MT[Lor1,Lor3] MT[Lor2,Lor4] SP[p1,p2] SP[p2,p3]+
MT[Lor1,Lor2] MT[Lor3,Lor4] SP[p1,p2] SP[p2,p3]+FV[p2,Lor1] ((FV[p1,Lor4] FV[p2,Lor3]+
FV[p1,Lor3] FV[p2,Lor4]) FV[p3,Lor2]+FV[p1,Lor2] FV[p2,Lor4] FV[p3,Lor3]+
2 FV[p2,Lor4] MT[Lor2,Lor3] SP[p1,p3]-FV[p2,Lor3] MT[Lor2,Lor4] SP[p1,p3]+
FV[p2,Lor2] (FV[p1,Lor4] FV[p3,Lor3]-MT[Lor3,Lor4] SP[p1,p3])-2 FV[p1,Lor4] MT[Lor2,Lor3] SP[p2,p3]-
FV[p1,Lor3] MT[Lor2,Lor4] SP[p2,p3]-FV[p1,Lor2] MT[Lor3,Lor4] SP[p2,p3]));


(* ::Subsection:: *)
(*Check*)


Print["Check vertices in the Euler-Heisenberg Lagrangian model: ",
			If[{Simplify[FCE[SelectNotFree2[amp,c1]]-c1Part],Simplify[FCE[SelectNotFree2[amp,c2]]-c2Part]}===Table[0,2], "CORRECT.", "!!! WRONG !!!"]];
