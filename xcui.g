ii := COMPLEX_I;

algrel := function(x,d,n)
    local p, q, i;
    
    x := Rat(x); p := NumeratorRat(x); q := DenominatorRat(x);
    x := IdentityMat(n+1);
    for i in [0..n] do Add(x[i+1],p^i*q^(n-i)); od;
    return LLLReducedBasis(x).basis[1];
end;

# ai are preimages of infinity, bi of 1, ci of 0.

a2 := 0.500000000000000000000000000000 - 0.439846359796987134487167714627*ii;
a3 := 1.61268567872451072013417667720 - 0.490182463946729812334860743821*ii;
a4 := 0.500000000000000000000000000000 - 0.0415300696430258467988035191529*ii;
a5 := -0.612685678724510720134176677204 - 0.490182463946729812334860743821*ii;
b2 := -0.127485151459011948734747094655 - 0.991840479188802206853242764751*ii;
b3 := 0.432359588377624320446470035702 - 0.172536644477962176299255320022*ii;
b4 := -0.986296566330715829847015755165 - 0.164982069462835473582606346591*ii;
b5 := 1.99516470514160943250266636145 - 0.796186860797306011242450678339*ii;
c2 := 1.12748515145901194873474709466 - 0.991840479188802206853242764751*ii;
c3 := 1.98629656633071582984701575517 - 0.164982069462835473582606346591*ii;
c4 := 0.567640411622375679553529964298 - 0.172536644477962176299255320022*ii;
c5 := -0.995164705141609432502666361446 - 0.796186860797306011242450678339*ii;
l  :=  7.69070477812435423714369570274*ii;

pre := CallFuncList(P1Map,List([infinity,1,0,a4,b4,c3],P1Point));

z := Indeterminate(COMPLEX_FIELD,"z":old);
#s := (b3-c3)*z+(a3-b3);
#t := a3*(b3-c3)*z+(a3-b3)*c3;
s := COMPLEX_1; t := z;

F2 := l*(  s)^4*(t-a2*s)^3*(t-a3*s)^2*(t-a4*s)^2*(t-a5*s)^2;
G2 := (t-s)^4*(t-b2*s)^3*(t-b3*s)^2*(t-b4*s)^2*(t-b5*s)^2;
H2 := (t  )^4*(t-c2*s)^3*(t-c3*s)^2*(t-c4*s)^2*(t-c5*s)^2;

delta := Sqrt(Sum(List(CoefficientsOfUnivariatePolynomial(F2-G2+H2),Norm)));
f := P1MapRational(-H2/F2)*pre;
m := IMGMachine(f);
perms := List([1..3],i->PermList(Output(m,i)));
goal := [(1,3,12,4)(5,9)(6,7)(10,13,11)(2,8),
         (1,5,13,6)(7,10)(2,3)(8,11,12)(4,9),
         (1,7,11,2)(3,8)(4,5)(9,12,13)(6,10)];
change := RepresentativeAction(SymmetricGroup(13),perms,goal,OnTuples);
newm := ChangeFRMachineBasis(m,change);
