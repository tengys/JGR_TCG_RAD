ensemble="ens0"
sen_exp=(/"diurnal","night","noon"/)
lenl=96
do sen_step=0,2
print(sen_exp(sen_step))
filenn="ls ../../chap3_budget/"+sen_exp(sen_step)+"/wrfout_d03*"
files=systemfunc(filenn)
f=addfiles(files,"r")
diurnal=asciiread("threshold"+sen_exp(sen_step)+ensemble+"_new.dat", (/25,300,300/), "integer")
conv=new((/3,48/),"float")
stra=new((/3,48/),"float")
conv=0.
stra=0.
;''''
out_mp=new((/2,12,33/),"float")
out_mp=0.
out_bl=new((/2,12,33/),"float")
out_bl=0.
out_adv=new((/2,12,33/),"float")
out_adv=0.
out_advh=new((/2,12,33/),"float")
out_advh=0.
out_advz=new((/2,12,33/),"float")
out_advz=0.
start=36
minx=asciiread("../minxy/"+sen_exp(sen_step)+"_"+ensemble+"_x", (/lenl/), "integer")
miny=asciiread("../minxy/"+sen_exp(sen_step)+"_"+ensemble+"_y", (/lenl/), "integer")
do time=37,48
diabatic=wrf_user_getvar(f,"QV_DIABATIC_ACCU",time-start)-wrf_user_getvar(f,"QV_DIABATIC_ACCU",time-start-1)
adv_h=wrf_user_getvar(f,"ADVEC_H",time-start)-wrf_user_getvar(f,"ADVEC_H",time-start-1)
adv_z=wrf_user_getvar(f,"ADVEC_Z",time-start)-wrf_user_getvar(f,"ADVEC_Z",time-start-1)
bl=wrf_user_getvar(f,"FRIC_ACCU",time-start)-wrf_user_getvar(f,"FRIC_ACCU",time-start-1)
;height=wrf_user_getvar(f,"z",time)
do level=0,32
counter=0
print(level)
do i=20,280
do j=20,280
if((i-150)*(i-150)+(j-150)*(j-150).le.80*80)
counter=counter+1
    if(diurnal(time-start-1,i,j).eq.1)
    out_mp(0,time-start-1,level)=out_mp(0,time-start-1,level)+diabatic(level,i,j)
    out_bl(0,time-start-1,level)=out_bl(0,time-start-1,level)+bl(level,i,j)
    out_adv(0,time-start-1,level)=out_adv(0,time-start-1,level)+adv_h(level,i,j)+adv_z(level,i,j)
    out_advh(0,time-start-1,level)=out_advh(0,time-start-1,level)+adv_h(level,i,j)
    out_advz(0,time-start-1,level)=out_advz(0,time-start-1,level)+adv_z(level,i,j)
    end if
    if(diurnal(time-start-1,i,j).eq.2)
    out_mp(1,time-start-1,level)=out_mp(1,time-start-1,level)+diabatic(level,i,j)
    out_bl(1,time-start-1,level)=out_bl(1,time-start-1,level)+bl(level,i,j)
    out_adv(1,time-start-1,level)=out_adv(1,time-start-1,level)+adv_h(level,i,j)+adv_z(level,i,j)
    out_advh(1,time-start-1,level)=out_advh(1,time-start-1,level)+adv_h(level,i,j)
    out_advz(1,time-start-1,level)=out_advz(1,time-start-1,level)+adv_z(level,i,j)
    end if
;out(3,time-start-1,level)=out(3,time-start-1,level)+(cfrac_center(i,j)-out(3,time-start-1,level))/counter
end if
end do
end do
out_mp(:,time-start-1,level)=out_mp(:,time-start-1,level)/counter
out_bl(:,time-start-1,level)=out_bl(:,time-start-1,level)/counter
out_adv(:,time-start-1,level)=out_adv(:,time-start-1,level)/counter
out_advh(:,time-start-1,level)=out_advh(:,time-start-1,level)/counter
out_advz(:,time-start-1,level)=out_advz(:,time-start-1,level)/counter
end do
end do
asciiwrite("mpavg"+sen_exp(sen_step)+ensemble+"160.dat", dim_avg_n_Wrap(out_mp,1))
asciiwrite("blavg"+sen_exp(sen_step)+ensemble+"160.dat", dim_avg_n_Wrap(out_bl,1))
asciiwrite("advavg"+sen_exp(sen_step)+ensemble+"160.dat", dim_avg_n_Wrap(out_adv,1))
asciiwrite("advhavg"+sen_exp(sen_step)+ensemble+"160.dat", dim_avg_n_Wrap(out_advh,1))
asciiwrite("advzavg"+sen_exp(sen_step)+ensemble+"160.dat", dim_avg_n_Wrap(out_advz,1))

delete(f)
end do
