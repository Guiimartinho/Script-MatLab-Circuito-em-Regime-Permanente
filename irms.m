function I = irms(y0,y1,x0,x1,t0,t1,T)

Eq1 = @(t) ((((y0 - y1)/(x0 - x1))*(t - x1) + y1)).^2;

I = sqrt(integral(Eq1,t0,t1) / T);
