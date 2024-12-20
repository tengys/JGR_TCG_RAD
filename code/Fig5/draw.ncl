names=(/"diurnal","noon","night"/)
files=systemfunc("ls  ../../chap3_budget/diurnal/wrfout_d03*")
f11=addfiles(files,"r")
z=wrf_user_getvar(f11,"height",3)
z_avg=dim_avg_n_Wrap(th, (/1,2/))
x=z_avg(0:32)/1000
result=new((/3,3,33/),float)
type=0
result=0.
startt=0
endt=11
bl_diurnal=asciiread("bldiurnalavg.dat",(/2,33/),"float")*1000*6
mp_diurnal=asciiread("mpdiurnalavg.dat",(/2,33/),"float")*1000*6
adv_diurnal=asciiread("advdiurnalavg.dat",(/2,33/),"float")*1000*6

bl_noon=asciiread("blnoonavg.dat",(/2,33/),"float")*1000*6
mp_noon=asciiread("mpnoonavg.dat",(/2,33/),"float")*1000*6
adv_noon=asciiread("advnoonavg.dat",(/2,33/),"float")*1000*6

bl_night=asciiread("blnightavg.dat",(/2,33/),"float")*1000*6
mp_night=asciiread("mpnightavg.dat",(/2,33/),"float")*1000*6
adv_night=asciiread("advnightavg.dat",(/2,33/),"float")*1000*6



bl_diurnal_std=asciiread("bldiurnalstd.dat",(/2,33/),"float")*1000*6
mp_diurnal_std=asciiread("mpdiurnalstd.dat",(/2,33/),"float")*1000*6
adv_diurnal_std=asciiread("advdiurnalstd.dat",(/2,33/),"float")*1000*6

bl_noon_std=asciiread("blnoonstd.dat",(/2,33/),"float")*1000*6
mp_noon_std=asciiread("mpnoonstd.dat",(/2,33/),"float")*1000*6
adv_noon_std=asciiread("advnoonstd.dat",(/2,33/),"float")*1000*6

bl_night_std=asciiread("blnightstd.dat",(/2,33/),"float")*1000*6
mp_night_std=asciiread("mpnightstd.dat",(/2,33/),"float")*1000*6
adv_night_std=asciiread("advnightstd.dat",(/2,33/),"float")*1000*6


xp    = new( (/2*33/), float )
yp    = new( (/2*33/), float )
do k=0,33-1
  yp(k) = x(k)
  xp(k) = 2*mp_diurnal_std(type,k)
  xp(2*33-1-k) = -2*mp_diurnal_std(type,k)
  yp(2*33-1-k) = x(k)
end do

xpnight    = new( (/2*33/), float )
ypnight    = new( (/2*33/), float )
do k=0,33-1
  ypnight(k) = x(k)
  xpnight(k) = mp_night(type,k)-mp_diurnal(type,k)+2*mp_night_std(type,k)
  xpnight(2*33-1-k) = mp_night(type,k)-mp_diurnal(type,k)-2*mp_night_std(type,k)
  ypnight(2*33-1-k) = x(k)
end do


xpnoon    = new( (/2*33/), float )
ypnoon    = new( (/2*33/), float )
do k=0,33-1
  ypnoon(k) = x(k)
  xpnoon(k) = mp_noon(type,k)-mp_diurnal(type,k)+2*mp_noon_std(type,k)
  xpnoon(2*33-1-k) = mp_noon(type,k)-mp_diurnal(type,k)-2*mp_noon_std(type,k)
  ypnoon(2*33-1-k) = x(k)
end do





xp1    = new( (/2*33/), float )
yp1    = new( (/2*33/), float )
do k=0,33-1
  yp1(k) = x(k)
  xp1(k) = 2*adv_diurnal_std(type,k)
  xp1(2*33-1-k) = -2*adv_diurnal_std(type,k)
  yp1(2*33-1-k) = x(k)
end do

xpnight1    = new( (/2*33/), float )
ypnight1    = new( (/2*33/), float )
do k=0,33-1
  ypnight1(k) = x(k)
  xpnight1(k) = adv_night(type,k)-adv_diurnal(type,k)+2*adv_night_std(type,k)
  xpnight1(2*33-1-k) = adv_night(type,k)-adv_diurnal(type,k)-2*adv_night_std(type,k)
  ypnight1(2*33-1-k) = x(k)
end do


xpnoon1    = new( (/2*33/), float )
ypnoon1    = new( (/2*33/), float )
do k=0,33-1
  ypnoon1(k) = x(k)
  xpnoon1(k) = adv_noon(type,k)-adv_diurnal(type,k)+2*adv_noon_std(type,k)
  xpnoon1(2*33-1-k) = adv_noon(type,k)-adv_diurnal(type,k)-2*adv_noon_std(type,k)
  ypnoon1(2*33-1-k) = x(k)
end do

res=True
res@gsnDraw      =  False                  
res@gsnFrame     =  False  
res@vpWidthF      = 0.6
res@vpHeightF     = 0.8
res@xyLineThicknessF=3
res@tmXBMajorOutwardLengthF = -0.001
res@tmXBMinorOutwardLengthF = -0.001
res@tmYLMajorOutwardLengthF = -0.001
res@tmYLMinorOutwardLengthF = -0.001
res@tmYRMajorOutwardLengthF = -0.001
res@tmYRMinorOutwardLengthF = -0.001
res@tmYLMode="Explicit"
res@tmYLValues=(/2,4,6,8,10,12/)
res@trYMaxF=12
res@trYMinF=0
res@trXMinF=-4.0
res@trXMaxF=4.0
res@tmYLMinorValues = ispan(0,24,1)/2.0
res@tmYLLabels=(/"~F25~2","~F25~4","~F25~6","~F25~8","~F25~10","~F25~12"/)
rr=res
res@tiYAxisString="~F25~Height (km)"
rr@tiXAxisString="~F25~(g/kg)"
ress=res
ress@xyLineColors=(/"black","red","blue"/)
ress@tiXAxisString="~F25~(10 ~S~-3~N~ g/kg)"
ress@xyDashPatterns=(/0,0,0/)
ress@trXMaxF=8
ress@trXMinF=-8
rr@xyDashPattern=0
colors=(/"red","blue"/)
rr@xyLineColors=colors
dashpatten=(/1,1/)
rr@xyDashPatterns=dashpatten
rr@trXMaxF=0.5
rr@trXMinF=-0.5
rr@gsnXRefLine=0
rr@gsnXRefLineColor="azure4"
rr@gsnXRefLineDashPattern=0
rr@gsnXRefLineThicknessF=2
res@tiMainFontHeightF=0.03

wks  = gsn_open_wks("eps", "conv")
plot = new(2,graphic) 

res@tiMainString="~F25~(a) Flux term"
plot(0)=gsn_csm_x2y(wks,(/adv_noon(type,:)-adv_diurnal(type,:),adv_night(type,:)-adv_diurnal(type,:)/),adv_diurnal(type,:),x,rr,res)
gsres                   = True                        ; poly res
gsres@gsFillOpacityF =0.2
gsres@tfPolyDrawOrder   = "Predraw"                   ; draw this first
gsres@gsFillColor       = "Black"    

dummy3= gsn_add_polygon (wks,plot(0),xp1,yp1,gsres)
gsres@gsFillColor       = "Red"    

dummy4 = gsn_add_polygon (wks,plot(0),xpnoon1,ypnoon1,gsres)
gsres@gsFillColor       = "Blue"    
dummy5 = gsn_add_polygon (wks,plot(0),xpnight1,ypnight1,gsres)

res@tiMainString="~F25~(b)  Microphysics term"
plot(1)=gsn_csm_x2y(wks,(/mp_noon(type,:)-mp_diurnal(type,:),mp_night(type,:)-mp_diurnal(type,:)/),mp_diurnal(type,:),x,rr,res)
gsres@gsFillColor       = "Black"    

dummy = gsn_add_polygon (wks,plot(1),xp,yp,gsres)
gsres@gsFillColor       = "Red"    

dummy1 = gsn_add_polygon (wks,plot(1),xpnoon,ypnoon,gsres)
gsres@gsFillColor       = "Blue"    

dummy2 = gsn_add_polygon (wks,plot(1),xpnight,ypnight,gsres)

resf=True
resf@gsnMaximize = True
gsn_panel(wks,plot,(/1,2/),resf)
