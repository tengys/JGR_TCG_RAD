ensemble="ens2"
sen_exp=(/"diurnal","night","noon"/)
do sen_step=0,2
print(sen_exp(sen_step))
filenn="ls /mnt/f/120km/"+ensemble+"/"+sen_exp(sen_step)+"/wrfout_d03*"
files=systemfunc(filenn)
f=addfiles(files,"r")
len=96
minx=new((/len/),float)
miny=new((/len/),float)
minx=150
miny=150
out=new((/len,300,300/),float)
do time =0,len-1
print(time)
maxavo=-1.
avo=wrf_user_getvar(f,"avo",time)
pres=wrf_user_getvar(f,"pres",time)
avo_surf=avo(0,:,:)
out(time,:,:)=avo_surf
end do
out(0,:,:)=out(1,:,:)
asciiwrite("avosurf_"+sen_exp(sen_step)+"_"+ensemble,out)
delete(f)
end do
