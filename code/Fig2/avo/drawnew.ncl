day=asciiread("surfnoonavg.dat",(/96/),"float")
diurnal=asciiread("surfdiurnalavg.dat",(/96/),"float")
night=asciiread("surfnightavg.dat",(/96/),"float")
day1=asciiread("4-6kmnoonavg.dat",(/96/),"float")
diurnal1=asciiread("4-6kmdiurnalavg.dat",(/96/),"float")
night1=asciiread("4-6kmnightavg.dat",(/96/),"float")

day_std=asciiread("surfnoonstd.dat",(/96/),"float")
diurnal_std=asciiread("surfdiurnalstd.dat",(/96/),"float")
night_std=asciiread("surfnightstd.dat",(/96/),"float")
day1_std=asciiread("4-6kmnoonstd.dat",(/96/),"float")
diurnal1_std=asciiread("4-6kmdiurnalstd.dat",(/96/),"float")
night1_std=asciiread("4-6kmnightstd.dat",(/96/),"float")
x=ispan(0,96-1,1)
xp    = new( (/2*96/), float )
yp    = new( (/2*96/), float )
do k=0,96-1
  xp(k) = x(k)
  yp(k) = diurnal(k)+2*diurnal_std(k)
  yp(2*96-1-k) = diurnal(k)-2*diurnal_std(k)
  xp(2*96-1-k) = x(k)
end do

xpnoon    = new( (/2*96/), float )
ypnoon    = new( (/2*96/), float )
do k=0,96-1
  xpnoon(k) = x(k)
  ypnoon(k) = day(k)+2*day_std(k)
  ypnoon(2*96-1-k) = day(k)-2*day_std(k)
  xpnoon(2*96-1-k) = x(k)
end do

xpnight    = new( (/2*96/), float )
ypnight   = new( (/2*96/), float )
do k=0,96-1
  xpnight(k) = x(k)
  ypnight(k) = night(k)+2*night_std(k)
  ypnight(2*96-1-k) = night(k)-2*night_std(k)
  xpnight(2*96-1-k) = x(k)
end do


xp1    = new( (/2*96/), float )
yp1    = new( (/2*96/), float )
do k=0,96-1
  xp1(k) = x(k)
  yp1(k) = diurnal1(k)+2*diurnal1_std(k)
  yp1(2*96-1-k) = diurnal1(k)-2*diurnal1_std(k)
  xp1(2*96-1-k) = x(k)
end do

xpnoon1    = new( (/2*96/), float )
ypnoon1    = new( (/2*96/), float )
do k=0,96-1
  xpnoon1(k) = x(k)
  ypnoon1(k) = day1(k)+2*day1_std(k)
  ypnoon1(2*96-1-k) = day1(k)-2*day1_std(k)
  xpnoon1(2*96-1-k) = x(k)
end do

xpnight1    = new( (/2*96/), float )
ypnight1   = new( (/2*96/), float )
do k=0,96-1
  xpnight1(k) = x(k)
  ypnight1(k) = night1(k)+2*night1_std(k)
  ypnight1(2*96-1-k) = night1(k)-2*night1_std(k)
  xpnight1(2*96-1-k) = x(k)
end do


plot      = new(2,"graphic")

colors=(/"red","blue","black"/)
res=True
res@xyLineColors=colors
res@xyDashPatterns=(/0,0,0/)
res@xyLineThicknessF=2
res@trXMaxF=84
res@vpWidthF      = 0.8
res@vpHeightF     = 0.6
res@gsnDraw              = False              ; don't draw
res@gsnFrame             = False  
res@tmXBMode="Explicit"
res@tmXBValues=(/0,24,48,72,96/)
res@tmXBLabels=(/"~F25~0h","~F25~24h","~F25~48h","~F25~72h","~F25~96h"/)
res@tmXBMinorValues = ispan(0,96,4)
;res@tmXBLabelFontHeightF = 0.015
res@tiXAxisString="~F25~Time (h)"
res@tiYAxisString="~F25~10~S~-5~N~ s ~S~-1~N~"
res@trYMinF=0
res@trYMaxF=25
res@tmXBMajorOutwardLengthF = -0.001
res@tmXBMinorOutwardLengthF = -0.001
res@tmYLMajorOutwardLengthF = -0.001
res@tmYLMinorOutwardLengthF = -0.001
res@tmYRMajorOutwardLengthF = -0.001
res@tmYRMinorOutwardLengthF = -0.001
wks  = gsn_open_wks("eps", "4-66km_test")
gsres                   = True                        ; poly res
gsres@gsFillOpacityF =0.2
gsres@tfPolyDrawOrder   = "Predraw"                   ; draw this first
res@tiMainString="~F25~(d) AVO at 4-6 km"
plot(1)=gsn_csm_xy(wks,x,(/day1,night1,diurnal1/),res)
gsres@gsFillColor       = "Black"     
dummy3 = gsn_add_polygon (wks,plot(1),xp1,yp1,gsres)
gsres@gsFillColor       = "Red"                 ; color chosen
dummy4 = gsn_add_polygon (wks,plot(1),xpnoon1,ypnoon1,gsres)
gsres@gsFillColor       = "Blue"                 ; color chosen
dummy5 = gsn_add_polygon (wks,plot(1),xpnight1,ypnight1,gsres)

res@tiMainString="~F25~(c) AVO at 10m"
plot(0)=gsn_csm_xy(wks,x,(/day,night,diurnal/),res)
gsres@gsFillColor       = "Black"                 ; color chosen
dummy = gsn_add_polygon (wks,plot(0),xp,yp,gsres)
gsres@gsFillColor       = "Red"                 ; color chosen
dummy1 = gsn_add_polygon (wks,plot(0),xpnoon,ypnoon,gsres)
gsres@gsFillColor       = "Blue"                 ; color chosen
dummy2 = gsn_add_polygon (wks,plot(0),xpnight,ypnight,gsres)

resall=True
resall@gsnMaximize=True
resall@vpWidthF      = 0.8
resall@vpHeightF     = 0.6
resall@gsnPanelDebug     = True 
gsn_panel(wks,plot,(/1,2/),False)