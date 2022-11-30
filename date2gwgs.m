function[gw,gs]=date2gwgs(year,month,day,hh,mm,ss)
%UT는 편의상 UT=hh+mm/60+ss/3600로 표현한다.
UT=hh+mm/60+ss/3600;
if month<=2
    NY=year-1;
    NM=month+12;
   
else
    NY=year;
    NM=month;
end

JD=floor(365.25*NY)+floor(30.6001*(NM+1))+day+UT/24+1720981.5;

gw=floor((JD-2444244.5)/7);

N=mod(floor(JD+0.5),7);

if N==6
    gg=0;
else
    gg=N+1;
end

gs=86400*gg+hh*3600+mm*60+ss;

fprintf(1,"결과 : gw: %6d, gs: %6d\n",gw,gs)
end
    