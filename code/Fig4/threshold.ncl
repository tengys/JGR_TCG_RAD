ensemble="ens0"
sen_exp=(/"diurnal","night","noon"/)
lenl=96
do sen_step=0,2
print(sen_exp(sen_step))
filenn="ls ../../chap3/"+ensemble+"/"+sen_exp(sen_step)+"/wrfout_d03*"
files=systemfunc(filenn)
f=addfiles(files,"r")
len=25
out=new((/len,300,300/),"float")
dbz_center=new((/300,300/),"float")
;0 no rain 1.convective 2. stratiform
out=0.
dbz_center=0.
start=36
minx=asciiread("../minxy/"+sen_exp(sen_step)+"_"+ensemble+"_x", (/lenl/), "integer")
miny=asciiread("../minxy/"+sen_exp(sen_step)+"_"+ensemble+"_y", (/lenl/), "integer")
do time=start,start+len-1

twc=wrf_user_getvar(f,"twp",time)

tlc=wrf_user_getvar(f,"tlp",time)
tic=wrf_user_getvar(f,"tip",time)

do i=0,299
do j= 0,299
if(twc(i,j).ge.0.1) 
if(tlc(i,j).le.0)
out(time-start,i,j)=2
else if((tic(i,j)/tlc(i,j).ge.2))
out(time-start,i,j)=2
else
out(time-start,i,j)=1
end if
end if
end if
end do
end do


print(time)
end do
asciiwrite("threshold"+sen_exp(sen_step)+ensemble+".dat",out)
delete(f)
end do
;wks  = gsn_open_wks("pdf", "dbz_center_diurnal111")
;res                       = True
;res@cnLinesOn= False
;res@cnFillOn = True
;plot=gsn_csm_contour(wks,out(0,:,:),res)
