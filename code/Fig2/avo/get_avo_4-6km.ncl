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
data=new((/5,300,300/),float)
out=new((/len,300,300/),float)
do time =0,len-1
print(time)
maxavo=-1.
avo=wrf_user_getvar(f,"avo",time)
height=wrf_user_getvar(f,"z",time)
do lev=0,4
data(lev,:,:)=wrf_user_intrp3d(avo,height,"h",4000+500*lev,0.,False)
end do
;avo_850=avo(0,:,:)
;avo_filter=avo_850
out(time,:,:)=dim_avg_n_Wrap(data,0)
;psfc=wrf_user_getvar(f,"PSFC",time)
;minpres=10000000.
;if(min(psfc).lt.101200)
;do i=100,200
;do j=100,200
;if(avg(psfc((i-2):(i+2),(j-2):(j+2))).lt.minpres)
;minpres=avg(psfc((i-2):(i+2),(j-2):(j+2)))
;minx(time)=i
;miny(time)=j
;end if
;end do
;end do
;end if
end do
out(0,:,:)=out(1,:,:)
;do time =67,len-1
;print(time)
;minpres=10000000.
;pres=wrf_user_getvar(f,"PSFC",time)
;do i=100,200
;do j=100,200
;if(avg(pres((i-2):(i+2),(j-2):(j+2))).lt.minpres)
;minpres=avg(pres((i-2):(i+2),(j-2):(j+2)))
;minx(time)=i
;miny(time)=j
;end if
;end do
;end do
;end do
asciiwrite("avo4-6km_"+sen_exp(sen_step)+"_"+ensemble,out)
delete(f)
end do
;asciiwrite("diurnal_y",miny)