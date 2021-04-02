clear % clear workspace
clc   % clear cmd window
%format long;%0.09 = 0.09
%format longE;%0.09 = 9e-02
%format ShortEng;%0.09 = 90e-003
format Short;%0.09 = 90e-003
sdisp = @(x) strtrim(evalc(sprintf('disp(%g)', x)));

E = 300;
f = 100*10^3;
L = 600*10^-6;
C = 100*10^-6;
D = 0.35;
PO = 1600;

T = 1/f;
VO = E/(1 - D);
R = E^2/(PO * ((1 - D)^2) );
IO = VO/R;

DL = E*D/(f*L);%OndulaÃ§Ã£o de corrente no indutor
IEM = IO/(1-D);% corrente fonte
ILM = IEM + (DL/2);% corrente maxima indutor
ILm = IEM - (DL/2);% corrente minima indutor

Lc = (((1 - D)^2)*D*R)/(2*f);

format ShortEng;
fprintf('Lcrítico = %s H\n', sdisp(Lc));
fprintf('L = %s H\n', sdisp(L));
if L > Lc
    fprintf('L > Lcrítico, Condução Contínua\n\n');
elseif L == Lc
    fprintf('L = Lcrítico, Condução Crítica\n\n');
else
    fprintf('L < Lcrítico, Condução Descontinua\n\n');
end
format Short;

fprintf('Para PO = %s W\n', sdisp(PO));
fprintf('R = %s Ohm\n', sdisp(R));
fprintf('VO = %s V\n', sdisp(VO));
fprintf('IO = %s A\n\n', sdisp(IO));

fprintf('Î”I = %s A\n', sdisp(DL));
fprintf('IEM = %s A\n', sdisp(IEM));
fprintf('ILM = %s A\n', sdisp(ILM));
fprintf('ILm = %s A\n\n', sdisp(ILm));

y0 = ILm;
y1 = ILM;
x0 = 0;
x1 = D*T;
t0 = 0;
t1 = D*T;

IS = imed(y0,y1,x0,x1,t0,t1,T);
fprintf('IS = %s A\n', sdisp(IS));

ISrms = irms(y0,y1,x0,x1,t0,t1,T);
fprintf('ISrms = %s A\n\n', sdisp(ISrms));

y0 = ILM;
y1 = ILm;
x0 = D*T;
x1 = T;
t0 = D*T;
t1 = T;

ID = imed(y0,y1,x0,x1,t0,t1,T);
fprintf('ID = %s A\n', sdisp(ID));

IDrms = irms(y0,y1,x0,x1,t0,t1,T);
fprintf('IDrms  = %s A\n\n', sdisp(IDrms ));

syms x
eqn = 1 + ((D^2)/(((2*L*x)/(E*T)))) == 1/(1-D);%x = Io, iguala as equa  continuo e 1 desconticuo
Io = solve(eqn);

fprintf('IO descontinuo = IO critico\nR > %s Ohm\nIO < %s A\n\n', sdisp(VO/Io), sdisp(Io));

syms x
eqn = x == E*(1 + ((D^2)/(((2*L*Io*0.7)/(E*T)))));%x = VO, q = VO/E, iguala VO/E a q descontinuo
Vo = solve(eqn);
Ri = Vo/(Io*0.7);

fprintf('Quando IO  = 70%% de IO critico\nR = %s Ohm\nVO = %s V\nIO = %s A\n', sdisp(Ri), sdisp(Vo), sdisp((Io*0.7)));
