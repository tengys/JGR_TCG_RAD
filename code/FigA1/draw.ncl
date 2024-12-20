names=(/"diurnal","noon","night"/)
files=systemfunc("ls  ../../chap3/ens0/diurnal/wrfout_d03*")
f11=addfiles(files,"r")
z=wrf_user_getvar(f11,"height",3)
z_avg=dim_avg_n_Wrap(th, (/1,2/))
z=th_1(2:20)/1000
result=new((/3,9,3,19/),float)
result=0.
startt=0
endt=36
ens=(/"ens0","ens1","ens2"/)
do ens_num=0,2
do exp_num=0,2
stri="ls  ../../chap33/"+ens(ens_num)+"/"+names(exp_num)+"/wrfout_d03*"
print(stri)
files=systemfunc(stri)
f11=addfiles(files,"r")
vo_new=wrf_user_getvar(f11,"VO_2",endt)
advh_new=wrf_user_getvar(f11,"STEPVO_ADVH_2",endt)
advv_new=wrf_user_getvar(f11,"STEPVO_ADVV_2",endt)
stre_new=wrf_user_getvar(f11,"STEPVO_STRE_2",endt)
tilt_new=wrf_user_getvar(f11,"STEPVO_TILT_2",endt)
baro_new=wrf_user_getvar(f11,"STEPVO_BARO_2",endt)
fric_new=wrf_user_getvar(f11,"STEPVO_FRIC_2",endt)

vo_old=wrf_user_getvar(f11,"VO_2",startt)
advh_old=wrf_user_getvar(f11,"STEPVO_ADVH_2",startt)
advv_old=wrf_user_getvar(f11,"STEPVO_ADVV_2",startt)
stre_old=wrf_user_getvar(f11,"STEPVO_STRE_2",startt)
tilt_old=wrf_user_getvar(f11,"STEPVO_TILT_2",startt)
baro_old=wrf_user_getvar(f11,"STEPVO_BARO_2",startt)
fric_old=wrf_user_getvar(f11,"STEPVO_FRIC_2",startt)

vo_change=vo_new-vo_old
advh_change=advh_new-advh_old
advv_change=advv_new-advv_old
stre_change=stre_new-stre_old
tilt_change=tilt_new-tilt_old
baro_change=baro_new-baro_old
fric_change=fric_new-fric_old
do k=2,20
counter=0
do i=40,260
do j=40,260
if((i-150)*(i-150)+(j-150)*(j-150).le.80*80)
counter=counter+1
result(ens_num,0,exp_num,k-2)=result(ens_num,0,exp_num,k-2)+(vo_change(k,i,j)-result(ens_num,0,exp_num,k-2))/counter
result(ens_num,2,exp_num,k-2)=result(ens_num,2,exp_num,k-2)+(advh_change(k,i,j)-result(ens_num,2,exp_num,k-2))/counter
result(ens_num,3,exp_num,k-2)=result(ens_num,3,exp_num,k-2)+(advv_change(k,i,j)-result(ens_num,3,exp_num,k-2))/counter
result(ens_num,4,exp_num,k-2)=result(ens_num,4,exp_num,k-2)+(stre_change(k,i,j)-result(ens_num,4,exp_num,k-2))/counter
result(ens_num,5,exp_num,k-2)=result(ens_num,5,exp_num,k-2)+(tilt_change(k,i,j)-result(ens_num,5,exp_num,k-2))/counter
end if
end do
end do
result(ens_num,1,exp_num,k-2)=result(ens_num,2,exp_num,k-2)+result(ens_num,3,exp_num,k-2)+result(ens_num,4,exp_num,k-2)+result(ens_num,5,exp_num,k-2)
result(ens_num,6,exp_num,k-2)=result(ens_num,2,exp_num,k-2)+result(ens_num,4,exp_num,k-2)
result(ens_num,7,exp_num,k-2)=result(ens_num,3,exp_num,k-2)+result(ens_num,5,exp_num,k-2)
result(ens_num,8,exp_num,k-2)=result(ens_num,0,exp_num,k-2)-result(ens_num,1,exp_num,k-2)
end do

delete(files)
delete(f11)
end do


end do
result=result*1000000000/(3600*(endt-startt))
result_avg=dim_avg_n_Wrap(result,0)
std= dim_stddev_n_Wrap(result,0)


xp    = new( (/2*19/), float )
yp    = new( (/2*19/), float )
do k=0,19-1
  yp(k) = x(k)
  xp(k) = result_avg(0,0,k)+2*std(0,0,k)
  xp(2*19-1-k) = result_avg(0,0,k)-2*std(0,0,k)
  yp(2*19-1-k) = x(k)
end do

xpnoon    = new( (/2*19/), float )
ypnoon    = new( (/2*19/), float )
do k=0,19-1
  ypnoon(k) = x(k)
  xpnoon(k) = result_avg(0,1,k)+2*std(0,1,k)
  xpnoon(2*19-1-k) = result_avg(0,1,k)-2*std(0,1,k)
  ypnoon(2*19-1-k) = x(k)
end do

xpnight    = new( (/2*19/), float )
ypnight    = new( (/2*19/), float )
do k=0,19-1
  ypnight(k) = x(k)
  xpnight(k) = result_avg(0,2,k)+2*std(0,2,k)
  xpnight(2*19-1-k) = result_avg(0,2,k)-2*std(0,2,k)
  ypnight(2*19-1-k) = x(k)
end do


xp6    = new( (/2*19/), float )
yp6    = new( (/2*19/), float )
do k=0,19-1
  yp6(k) = x(k)
  xp6(k) = result_avg(2,0,k)+2*std(2,0,k)
  xp6(2*19-1-k) = result_avg(2,0,k)-2*std(2,0,k)
  yp6(2*19-1-k) = x(k)
end do

xpnoon6    = new( (/2*19/), float )
ypnoon6    = new( (/2*19/), float )
do k=0,19-1
  ypnoon6(k) = x(k)
  xpnoon6(k) = result_avg(2,1,k)+2*std(2,1,k)
  xpnoon6(2*19-1-k) = result_avg(2,1,k)-2*std(2,1,k)
  ypnoon6(2*19-1-k) = x(k)
end do

xpnight6    = new( (/2*19/), float )
ypnight6    = new( (/2*19/), float )
do k=0,19-1
  ypnight6(k) = x(k)
  xpnight6(k) = result_avg(2,2,k)+2*std(2,2,k)
  xpnight6(2*19-1-k) = result_avg(2,2,k)-2*std(2,2,k)
  ypnight6(2*19-1-k) = x(k)
end do


xp7    = new( (/2*19/), float )
yp7    = new( (/2*19/), float )
do k=0,19-1
  yp7(k) = x(k)
  xp7(k) = result_avg(3,0,k)+2*std(3,0,k)
  xp7(2*19-1-k) = result_avg(3,0,k)-2*std(3,0,k)
  yp7(2*19-1-k) = x(k)
end do

xpnoon7    = new( (/2*19/), float )
ypnoon7    = new( (/2*19/), float )
do k=0,19-1
  ypnoon7(k) = x(k)
  xpnoon7(k) = result_avg(3,1,k)+2*std(3,1,k)
  xpnoon7(2*19-1-k) = result_avg(3,1,k)-2*std(3,1,k)
  ypnoon7(2*19-1-k) = x(k)
end do

xpnight7    = new( (/2*19/), float )
ypnight7    = new( (/2*19/), float )
do k=0,19-1
  ypnight7(k) = x(k)
  xpnight7(k) = result_avg(3,2,k)+2*std(3,2,k)
  xpnight7(2*19-1-k) = result_avg(3,2,k)-2*std(3,2,k)
  ypnight7(2*19-1-k) = x(k)
end do

res=True
res@gsnMaximize = True
res@gsnDraw      =  False                   ; do not draw the plot
res@gsnFrame     =  False  
res@vpWidthF      = 0.4
res@vpHeightF     = 0.8
res@xyLineThicknessF=2
res@gsnXRefLine=0
res@tiXAxisString="~F25~(10~S~-9~N~ s ~S~-2~N~)"
res@tiYAxisString="~F25~ Height (km)"
res@tmXBMajorOutwardLengthF = -0.001
res@tmXBMinorOutwardLengthF = -0.001
res@tmYLMajorOutwardLengthF = -0.001
res@tmYLMinorOutwardLengthF = -0.001
res@tmYRMajorOutwardLengthF = -0.001
res@tmYRMinorOutwardLengthF = -0.001
colors=(/"black","red","blue"/)
res@xyLineColors=colors
dashpatten=(/0,0,0/)
res@xyDashPatterns=dashpatten

res@tmYLMode="Explicit"
res@tmYLValues=(/1000,2000,3000,4000,5000,6000,7000/)
res@trYMaxF=4000
res@trYMinF=0
res@tmYLLabels=(/"1","2","3","4","5","6","7"/)
res@tmYLMinorValues=ispan(0,7000,250)
res@trXMaxF=1.5
res@trXMinF=-1.5
wks  = gsn_open_wks("eps", "FigA1_up")
plot = new(9,graphic) 

res@tiMainString="~F25~(a) LHS"
plot(0)=gsn_csm_xy(wks,result_avg(0,:,:),x,res)
gsres                   = True                        ; poly res
gsres@gsFillOpacityF =0.2
gsres@tfPolyDrawOrder   = "Predraw"                   ; draw this first
gsres@gsFillColor       = "Black"                 ; color chosen
dummy = gsn_add_polygon (wks,plot(0),xp,yp,gsres)
gsres@gsFillColor       = "Red"                 ; color chosen
dummy1 = gsn_add_polygon (wks,plot(0),xpnoon,ypnoon,gsres)
gsres@gsFillColor       = "Blue"                 ; color chosen
dummy2 = gsn_add_polygon (wks,plot(0),xpnight,ypnight,gsres)
res@trXMaxF=20
res@trXMinF=-20
res@tiMainString="~F25~(c) Horizontal advction  "
plot(1)=gsn_csm_xy(wks,result_avg(2,:,:),x,res)


gsres@gsFillColor       = "Black"                 ; color chosen
dummy6 = gsn_add_polygon (wks,plot(1),xp6,yp6,gsres)
gsres@gsFillColor       = "Red"                 ; color chosen
dummy16 = gsn_add_polygon (wks,plot(1),xpnoon6,ypnoon6,gsres)
gsres@gsFillColor       = "Blue"                 ; color chosen
dummy26 = gsn_add_polygon (wks,plot(1),xpnight6,ypnight6,gsres)


res@tiMainString="~F25~(e) Vertical advction  "
plot(2)=gsn_csm_xy(wks,result_avg(3,:,:),x,res)

gsres@gsFillColor       = "Black"                 ; color chosen
dummy7 = gsn_add_polygon (wks,plot(2),xp7,yp7,gsres)
gsres@gsFillColor       = "Red"                 ; color chosen
dummy17 = gsn_add_polygon (wks,plot(2),xpnoon7,ypnoon7,gsres)
gsres@gsFillColor       = "Blue"                 ; color chosen
dummy27 = gsn_add_polygon (wks,plot(2),xpnight7,ypnight7,gsres)
resf=True
resf@gsnMaximize = True
gsn_panel(wks,plot,(/1,3/),resf)
