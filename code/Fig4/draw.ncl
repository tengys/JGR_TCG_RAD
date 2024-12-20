diurnalmp=asciiread("mpdiurnalavg_newruppert_160.dat",(/3,71/),"float")
daymp=asciiread("mpnoonavg_newruppert_160.dat",(/3,71/),"float")
nightmp=asciiread("mpnightavg_newruppert_160.dat",(/3,71/),"float")
diurnalmpstd=asciiread("mpdiurnalstd_newruppert_160.dat",(/3,71/),"float")
daympstd=asciiread("mpnoonstd_newruppert_160.dat",(/3,71/),"float")
nightmpstd=asciiread("mpnightstd_newruppert_160.dat",(/3,71/),"float")

diurnalrad=asciiread("raddiurnalavg_newruppert_160.dat",(/3,71/),"float")
dayrad=asciiread("radnoonavg_newruppert_160.dat",(/3,71/),"float")
nightrad=asciiread("radnightavg_newruppert_160.dat",(/3,71/),"float")
diurnalradstd=asciiread("raddiurnalstd_newruppert_160.dat",(/3,71/),"float")
dayradstd=asciiread("radnoonstd_newruppert_160.dat",(/3,71/),"float")
nightradstd=asciiread("radnightstd_newruppert_160.dat",(/3,71/),"float")



diurnalmp_grad=asciiread("mp_graddiurnalavg_newruppert_160.dat",(/3,71/),"float")
daymp_grad=asciiread("mp_gradnoonavg_newruppert_160.dat",(/3,71/),"float")
nightmp_grad=asciiread("mp_gradnightavg_newruppert_160.dat",(/3,71/),"float")
diurnalmp_gradstd=asciiread("mp_graddiurnalstd_newruppert_160.dat",(/3,71/),"float")
daymp_gradstd=asciiread("mp_gradnoonstd_newruppert_160.dat",(/3,71/),"float")
nightmp_gradstd=asciiread("mp_gradnightstd_newruppert_160.dat",(/3,71/),"float")

diurnalrad_grad=asciiread("rad_graddiurnalavg_newruppert_160.dat",(/3,71/),"float")
dayrad_grad=asciiread("rad_gradnoonavg_newruppert_160.dat",(/3,71/),"float")
nightrad_grad=asciiread("rad_gradnightavg_newruppert_160.dat",(/3,71/),"float")
diurnalrad_gradstd=asciiread("rad_graddiurnalstd_newruppert_160.dat",(/3,71/),"float")
dayrad_gradstd=asciiread("rad_gradnoonstd_newruppert_160.dat",(/3,71/),"float")
nightrad_gradstd=asciiread("rad_gradnightstd_newruppert_160.dat",(/3,71/),"float")




type=0
print(type)
x=ispan(0,60,1)
wks  = gsn_open_wks("eps", "Fig4")
lh=new((/3,61/),"float")
lh(0,:)=diurnalmp(type,0:60)*86400
lh(1,:)=daymp(type,0:60)*86400
lh(2,:)=nightmp(type,0:60)*86400
rad=new((/3,61/),"float")
rad(0,:)=diurnalrad(type,0:60)*86400
rad(1,:)=dayrad(type,0:60)*86400
rad(2,:)=nightrad(type,0:60)*86400

lh_grad=new((/3,61/),"float")
lh_grad(0,:)=diurnalmp_grad(type,0:60)*86400
lh_grad(1,:)=daymp_grad(type,0:60)*86400
lh_grad(2,:)=nightmp_grad(type,0:60)*86400
rad_grad=new((/3,61/),"float")
rad_grad(0,:)=diurnalrad_grad(type,0:60)*86400
rad_grad(1,:)=dayrad_grad(type,0:60)*86400
rad_grad(2,:)=nightrad_grad(type,0:60)*86400

xp    = new( (/2*61/), float )
yp    = new( (/2*61/), float )
do k=0,61-1
  yp(k) = x(k)
  xp(k) = 2*diurnalmpstd(type,k)*86400
  xp(2*61-1-k) = -2*diurnalmpstd(type,k)*86400
  yp(2*61-1-k) = x(k)
end do
xpnoon    = new( (/2*61/), float )
ypnoon    = new( (/2*61/), float )
do k=0,61-1
  ypnoon(k) = x(k)
  xpnoon(k) = lh(1,k)-lh(0,k)+2*daympstd(type,k)*86400
  xpnoon(2*61-1-k) = lh(1,k)-lh(0,k)-2*daympstd(type,k)*86400
  ypnoon(2*61-1-k) = x(k)
end do
xpnight    = new( (/2*61/), float )
ypnight    = new( (/2*61/), float )
do k=0,61-1
  ypnight(k) = x(k)
  xpnight(k) = lh(2,k)-lh(0,k)+2*nightmpstd(type,k)*86400
  xpnight(2*61-1-k) = lh(2,k)-lh(0,k)-2*nightmpstd(type,k)*86400
  ypnight(2*61-1-k) = x(k)
end do
xp1    = new( (/2*61/), float )
yp1    = new( (/2*61/), float )
do k=0,61-1
  yp1(k) = x(k)
  xp1(k) = 2*diurnalradstd(type,k)*86400
  xp1(2*61-1-k) = -2*diurnalradstd(type,k)*86400
  yp1(2*61-1-k) = x(k)
end do
xpnoon1    = new( (/2*61/), float )
ypnoon1    = new( (/2*61/), float )
do k=0,61-1
  ypnoon1(k) = x(k)
  xpnoon1(k) = rad(1,k)-rad(0,k)+2*dayradstd(type,k)*86400
  xpnoon1(2*61-1-k) = rad(1,k)-rad(0,k)-2*dayradstd(type,k)*86400
  ypnoon1(2*61-1-k) = x(k)
end do

xpnight1    = new( (/2*61/), float )
ypnight1    = new( (/2*61/), float )
do k=0,61-1
  ypnight1(k) = x(k)
  xpnight1(k) = rad(2,k)-rad(0,k)+2*nightradstd(type,k)*86400
  xpnight1(2*61-1-k) = rad(2,k)-rad(0,k)-2*nightradstd(type,k)*86400
  ypnight1(2*61-1-k) = x(k)
end do




xp_grad    = new( (/2*61/), float )
yp_grad    = new( (/2*61/), float )
do k=0,61-1
  yp_grad(k) = x(k)
  xp_grad(k) = 2*diurnalmp_gradstd(type,k)*86400
  xp_grad(2*61-1-k) = -2*diurnalmp_gradstd(type,k)*86400
  yp_grad(2*61-1-k) = x(k)
end do

xpnoon_grad    = new( (/2*61/), float )
ypnoon_grad    = new( (/2*61/), float )
do k=0,61-1
  ypnoon_grad(k) = x(k)
  xpnoon_grad(k) = lh_grad(1,k)-lh_grad(0,k)+2*daymp_gradstd(type,k)*86400
  xpnoon_grad(2*61-1-k) = lh_grad(1,k)-lh_grad(0,k)-2*daymp_gradstd(type,k)*86400
  ypnoon_grad(2*61-1-k) = x(k)
end do

xpnight_grad    = new( (/2*61/), float )
ypnight_grad    = new( (/2*61/), float )
do k=0,61-1
  ypnight_grad(k) = x(k)
  xpnight_grad(k) = lh_grad(2,k)-lh_grad(0,k)+2*nightmp_gradstd(type,k)*86400
  xpnight_grad(2*61-1-k) = lh_grad(2,k)-lh_grad(0,k)-2*nightmp_gradstd(type,k)*86400
  ypnight_grad(2*61-1-k) = x(k)
end do

xp1_grad    = new( (/2*61/), float )
yp1_grad    = new( (/2*61/), float )
do k=0,61-1
  yp1_grad(k) = x(k)
  xp1_grad(k) = 2*diurnalrad_gradstd(type,k)*86400
  xp1_grad(2*61-1-k) = -2*diurnalrad_gradstd(type,k)*86400
  yp1_grad(2*61-1-k) = x(k)
end do

xpnoon1_grad    = new( (/2*61/), float )
ypnoon1_grad    = new( (/2*61/), float )
do k=0,61-1
  ypnoon1_grad(k) = x(k)
  xpnoon1_grad(k) = rad_grad(1,k)-rad_grad(0,k)+2*dayrad_gradstd(type,k)*86400
  xpnoon1_grad(2*61-1-k) = rad_grad(1,k)-rad_grad(0,k)-2*dayrad_gradstd(type,k)*86400
  ypnoon1_grad(2*61-1-k) = x(k)
end do

xpnight1_grad    = new( (/2*61/), float )
ypnight1_grad    = new( (/2*61/), float )
do k=0,61-1
  ypnight1_grad(k) = x(k)
  xpnight1_grad(k) = rad_grad(2,k)-rad_grad(0,k)+2*nightrad_gradstd(type,k)*86400
  xpnight1_grad(2*61-1-k) = rad_grad(2,k)-rad_grad(0,k)-2*nightrad_gradstd(type,k)*86400
  ypnight1_grad(2*61-1-k) = x(k)
end do


colors=(/"black","red","blue"/)
plot      = new(4,"graphic")
res=True
res@gsnDraw              = False              ; don't draw
res@gsnFrame             = False 
res@trYMinF =1
res@tmXBMode="Explicit"
res@xyLineColors=colors
res@xyDashPatterns=(/0,0,0/)
res@tmXBValues=(/-20.0,-15.0,-10.0,-5.0,0.0,5.0,10.0,15.0,20.0/)
res@xyLineThicknessF=3

res@vpWidthF      = 0.45
res@vpHeightF     = 0.8
res@tmXBLabels=(/"~F25~-20","~F25~-15","~F25~-10","~F25~-5","~F25~0","~F25~5","~F25~10","~F25~15","~F25~20"/)
res@trXMinF     = -20.0
res@trXMaxF     = 20.0
res@tmYLMode="Explicit"
res@tmYLValues=(/0,10,20,30,40,50,60/)
res@tmYLMinorValues = ispan(0,60,2)
res@tmYLLabels=(/"~F25~0","~F25~2","~F25~4","~F25~6","~F25~8","~F25~10","~F25~12"/)

res@tmXBMajorOutwardLengthF = -0.001
  res@tmXBMinorOutwardLengthF = -0.001
  res@tmYLMajorOutwardLengthF = -0.001
  res@tmYLMinorOutwardLengthF = -0.001
  res@tmYRMajorOutwardLengthF = -0.001
  res@tmYRMinorOutwardLengthF = -0.001
resn=res
res@tiMainFontHeightF=0.03
res@tiMainString="~F25~(a) Latent Heating "
res@tiYAxisString="~F25~Height (km)"
resn@tiXAxisString="~F25~(K day ~S~-1~N~)"
resn@trXMaxF     = 5
resn@trXMinF     = -5
resn@gsnXRefLine=0
resn@gsnXRefLineColor="grey"
resn@gsnXRefLineDashPattern=1
resn@gsnXRefLineThicknessF=2
resn@tmXBValues=(/-10,-7.5,-5,-2.5,0,2.5,5,7.5,10/)
resn@tmXBLabels=(/"~F25~-10","~F25~-7.5","~F25~-5","~F25~-2.5","~F25~0","~F25~2.5","~F25~5","~F25~7.5","~F25~10"/)
resn@tmXBMinorValues = ispan(-10,10,1)/2.0
colorss=(/"red","blue","black"/)
resn@xyLineColors=colorss
resn@xyDashPatterns=(/1,1,1/)
plot(0)=gsn_csm_x2y(wks,(/lh(1,:)-lh(0,:),lh(2,:)-lh(0,:)/),lh(0,:),x,resn,res)

gsres                   = True                        ; poly res
gsres@gsFillOpacityF =0.2
gsres@tfPolyDrawOrder   = "Predraw"                   ; draw this first
gsres@gsFillColor       = "Black"    
;gsres@axis            ; color chosen
dummy = gsn_add_polygon (wks,plot(0),xp,yp,gsres)

gsres@gsFillColor       = "Red"    
;gsres@axis            ; color chosen
dummy1 = gsn_add_polygon (wks,plot(0),xpnoon,ypnoon,gsres)

gsres@gsFillColor       = "Blue"    
;gsres@axis            ; color chosen
dummy2 = gsn_add_polygon (wks,plot(0),xpnight,ypnight,gsres)

res@pmLegendDisplayMode    = "NoCreate"   
;res@tmYLLabelsOn=False
;res@tiYAxisOn=False
res@trXMaxF     = 20
res@trYMinF     =2
res@tiMainString="~F25~(b) ~F34~6~F25~Q~B~L~N~/~F34~6~F25~z "
res@trXMaxF     = 12 
res@trXMinF     = -12
resn@trXMaxF     = 2.5
resn@trXMinF     = -2.5
resn@tiXAxisString="~F25~(K day~S~-1~N~ km~S~-1~N~)"

plot(1)=gsn_csm_x2y(wks,(/lh_grad(1,:)-lh_grad(0,:),lh_grad(2,:)-lh_grad(0,:)/),lh_grad(0,:),x,resn,res)
gsres@gsFillColor       = "Black"    
dummy7 = gsn_add_polygon (wks,plot(1),xp_grad,yp_grad,gsres)

gsres@gsFillColor       = "Red"    
dummy8 = gsn_add_polygon (wks,plot(1),xpnoon_grad,ypnoon_grad,gsres)

gsres@gsFillColor       = "Blue"    
dummy9 = gsn_add_polygon (wks,plot(1),xpnight_grad,ypnight_grad,gsres)
res@tiMainString="~F25~(c) ~F34~6~F25~Q~B~R~N~/~F34~6~F25~z "
plot(3)=gsn_csm_x2y(wks,(/rad_grad(1,:)-rad_grad(0,:),rad_grad(2,:)-rad_grad(0,:)/),rad(0,:),x,resn,res)
gsres@gsFillColor       = "Black"    
dummy10 = gsn_add_polygon (wks,plot(3),xp1_grad,yp1_grad,gsres)

gsres@gsFillColor       = "Red"    
dummy11 = gsn_add_polygon (wks,plot(3),xpnoon1_grad,ypnoon1_grad,gsres)

gsres@gsFillColor       = "Blue"    
dummy12 = gsn_add_polygon (wks,plot(3),xpnight1_grad,ypnight1_grad,gsres)
res@trXMaxF     = 5  
res@tiMainString="~F25~(d) Radiative Heating "
res@tmXBMinorValues = ispan(-5,5,1)
res@trXMinF     = -5
resn@tiXAxisString="~F25~(K day ~S~-1~N~)"
resn@trXMaxF     = 5
resn@trXMinF     = -5
resn@tmXBMinorValues = ispan(-10,10,1)/2.0
plot(2)=gsn_csm_x2y(wks,(/rad(1,:)-rad(0,:),rad(2,:)-rad(0,:)/),rad(0,:),x,resn,res)
gsres@gsFillColor       = "Black" 
dummy3 = gsn_add_polygon (wks,plot(2),xp1,yp1,gsres)

gsres@gsFillColor       = "Red"    

dummy4 = gsn_add_polygon (wks,plot(2),xpnoon1,ypnoon1,gsres)

gsres@gsFillColor       = "Blue"    

dummy5 = gsn_add_polygon (wks,plot(2),xpnight1,ypnight1,gsres)
gsn_panel(wks,plot,(/1,4/),True)
