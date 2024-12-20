ensemble="ens2"
sen_exp=(/"diurnal","night","noon"/)
lenl=96
do sen_step=0,2
print(sen_exp(sen_step))
filenn="ls ../../chap3/"+ensemble+"/"+sen_exp(sen_step)+"/wrfout_d03*"
files=systemfunc(filenn)
f=addfiles(files,"r")
gas_const = 287.  ; J/K/kg
Cp = 1004. ; J/K/kg
len=36
start=36
minx=asciiread("../minxy/"+sen_exp(sen_step)+"_"+ensemble+"_x", (/lenl/), "integer")
miny=asciiread("../minxy/"+sen_exp(sen_step)+"_"+ensemble+"_y", (/lenl/), "integer")
result=new((/len,81,61/),float)
result=0.
wa_plane=new((/61,300,300/),float)
do time=start,start+len-1
print(time)
;printVarSummary(height)
wa=wrf_user_getvar(f,"wa",time)
pres=wrf_user_getvar(f,"pressure",time)
height=wrf_user_getvar(f,"z",time)
do k=0,60
if(k.eq.0)
hh=40
else
hh=k*200
end if 
wa_plane(k,:,:) = wrf_user_intrp3d(wa,height,"h",hh,0.,False)
end do
do k=0,60
counter=0
do i=40,260
do j=40,260
if((i-150)*(i-150)+(j-150)*(j-150).lt.6400)
counter=counter+1
if(wa_plane(k,i,j).lt.2.025 .and. wa_plane(k,i,j).gt.-2.025)
result(time-start,floattoint((wa_plane(k,i,j)+2.025)/0.05),k)=result(time-start,floattoint((wa_plane(k,i,j)+2.025)/0.05),k)+1
end if
end if
end do
end do

end do

end do
result=result/counter
asciiwrite("CFAD160"+sen_exp(sen_step)+ensemble+".dat",result)
delete(f)
end do
