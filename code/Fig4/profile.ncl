ensemble="ens2"
sen_exp=(/"diurnal","night","noon"/)
lenl=96
do sen_step=0,2
print(sen_exp(sen_step))
filenn="ls ../../chap3/"+ensemble+"/"+sen_exp(sen_step)+"/wrfout_d03*"
files=systemfunc(filenn)
f=addfiles(files,"r")
diurnal=asciiread("threshold"+sen_exp(sen_step)+ensemble+"_new.dat", (/25,300,300/), "integer")
conv=new((/3,48/),"float")
stra=new((/3,48/),"float")
conv=0.
stra=0.
out_mp=new((/3,25,71/),"float")
out_mp=0.
out_rad=new((/3,25,71/),"float")
out_rad=0.
out_mp_grad=new((/3,25,71/),"float")
out_mp_grad=0.
out_rad_grad=new((/3,25,71/),"float")
out_rad_grad=0.
start=36
minx=asciiread("../minxy/"+sen_exp(sen_step)+"_"+ensemble+"_x", (/lenl/), "integer")
miny=asciiread("../minxy/"+sen_exp(sen_step)+"_"+ensemble+"_y", (/lenl/), "integer")
do time=36,60
mp=wrf_user_getvar(f,"H_DIABATIC",time)
rad=wrf_user_getvar(f,"RTHRATEN",time)
height=wrf_user_getvar(f,"z",time)
do level=0,70
print(level)
if(level.eq.0)
hh=40
else
hh=level*200
end if 
mp_plane = wrf_user_intrp3d(mp,height,"h",hh,0.,False)
rad_plane = wrf_user_intrp3d(rad,height,"h",hh,0.,False)
counter=0
do i=20,280
do j=20,280
if((i-150)*(i-150)+(j-150)*(j-150).lt.80*80)
counter=counter+1
    if(diurnal(time-start,i,j).eq.1)
    out_mp(0,time-start,level)=out_mp(0,time-start,level)+mp_plane(i,j)
    out_rad(0,time-start,level)=out_rad(0,time-start,level)+rad_plane(i,j)
    end if
    if(diurnal(time-start,i,j).eq.2)
    out_mp(1,time-start,level)=out_mp(1,time-start,level)+mp_plane(i,j)
    out_rad(1,time-start,level)=out_rad(1,time-start,level)+rad_plane(i,j)
    end if
    if(diurnal(time-start,i,j).eq.0)
    out_mp(2,time-start,level)=out_mp(2,time-start,level)+mp_plane(i,j)
    out_rad(2,time-start,level)=out_rad(2,time-start,level)+rad_plane(i,j)
    end if
end if
end do
end do
out_mp(:,time-start,level)=out_mp(:,time-start,level)/counter
out_rad(:,time-start,level)=out_rad(:,time-start,level)/counter
end do


do i=1,59
out_mp_grad(0,time-start,i)=((out_mp(0,time-start,i+1))-(out_mp(0,time-start,i-1)))/0.4
out_mp_grad(1,time-start,i)=((out_mp(1,time-start,i+1))-(out_mp(1,time-start,i-1)))/0.4
out_mp_grad(2,time-start,i)=((out_mp(2,time-start,i+1))-(out_mp(2,time-start,i-1)))/0.4

out_rad_grad(0,time-start,i)=((out_rad(0,time-start,i+1))-(out_rad(0,time-start,i-1)))/0.4
out_rad_grad(1,time-start,i)=((out_rad(1,time-start,i+1))-(out_rad(1,time-start,i-1)))/0.4
out_rad_grad(2,time-start,i)=((out_rad(2,time-start,i+1))-(out_rad(2,time-start,i-1)))/0.4
end do

end do
asciiwrite("mp"+sen_exp(sen_step)+ensemble+"_newruppert_160.dat", out_mp)
asciiwrite("rad"+sen_exp(sen_step)+ensemble+"_newruppert_160.dat", out_rad)
asciiwrite("mp_grad"+sen_exp(sen_step)+ensemble+"_newruppert_160.dat", out_mp_grad)
asciiwrite("rad_grad"+sen_exp(sen_step)+ensemble+"_newruppert_160.dat", out_rad_grad)

delete(f)
end do
