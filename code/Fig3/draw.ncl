night_windt=asciiread("WIND_PROFILEnightavg.dat",(/36,61,81/),"float")
diurnal_windt=asciiread("WIND_PROFILEdiurnalavg.dat",(/36,61,81/),"float")
day_windt=asciiread("WIND_PROFILEnoonavg.dat",(/36,61,81/),"float")

night_windr=asciiread("radicalnightavg.dat",(/36,61,81/),"float")
diurnal_windr=asciiread("radicaldiurnalavg.dat",(/36,61,81/),"float")
day_windr=asciiread("radicalnoonavg.dat",(/36,61,81/),"float")

wks  = gsn_open_wks("eps", "Fig3")
diurnal_windr_36_72=diurnal_windr(0:35,:,:) 
diurnal_windr_36_72r_avg=dim_avg_n(diurnal_windr_36_72,0)

night_windr_36_72=night_windr(0:35,:,:) 
night_windr_36_72_avg=dim_avg_n(night_windr_36_72,0)

day_windr_36_72=day_windr(0:35,:,:) ;change the time stage
day_windr_36_72_avg=dim_avg_n(day_windr_36_72,0)

diurnal_windt_36_72t=diurnalt_wind(0:35,:,:) ;change the time stage
diurnal_windt_36_72t_avg=dim_avg_n(diurnal_windt_36_72,0)

night_windt_36_72=night_windt(0:35,:,:) ;change the time stage
night_windt_36_72_avg=dim_avg_n(night_windt_36_72,0)

day_windt_36_72=day_windt(0:35,:,:) ;change the time stage
day_windt_36_72_avg=dim_avg_n(day_windt_36_72,0)

plot      = new(3,"graphic")
res                       = True

  res@gsnDraw              = False              ; don't draw
  res@gsnFrame             = False              ; don't advance frame
res@vpWidthF      = 0.8
res@vpHeightF     = 0.5
resc=res

resc@cnMinLevelValF=8.0
resc@cnLevelSpacingF=4.0
resc@cnMaxLevelValF=12.0
resc@cnLineLabelInterval=1
resc@cnInfoLabelOn=False

res@cnFillOn = True
res@cnLevelSelectionMode = "ManualLevels"
res@cnLinesOn= False
res@cnMinLevelValF=-1
res@cnLevelSpacingF=0.1
res@cnLineLabelInterval=1
res@cnMaxLevelValF=1
res@tiMainFontHeightF=0.023
res@tiMainOffsetYF=-0.005
res@tmXBMajorOutwardLengthF = -0.001
res@tmXBMinorOutwardLengthF = -0.001
res@tmYLMajorOutwardLengthF = -0.001
res@tmYLMinorOutwardLengthF = -0.001
res@tmYRMajorOutwardLengthF = -0.001
res@tmYRMinorOutwardLengthF = -0.001
gsn_define_colormap(wks,"MPL_GnBu");MPL_bwr
res@tmXBMode="Explicit"
res@tmXBValues=(/0,20,40,60,80/)
res@tmXBMinorValues = ispan(0,80,5)
res@tmXBLabels=(/"~F25~0","~F25~40","~F25~80","~F25~120","~F25~160"/)
res@tmYLMode="Explicit"
res@tmYLValues=(/0,10,20,30,40,50,60/)
res@tmYLMinorValues = ispan(0,60,2)
res@tmYLLabels=(/"~F25~0","~F25~2","~F25~4","~F25~6","~F25~8","~F25~10","~F25~12"/)
res@lbOrientation = "vertical"
res@tiYAxisString="~F25~Height (km)"
res@tiXAxisString="~F25~Radius (km)"

res@cnInfoLabelOn=False

res@tiMainString="~F25~(a) CTRL (36-72h)"
res@tiYAxisOn=True
res@tmYLLabelsOn=True
plot(0)=gsn_csm_contour(wks,diurnal_windr_36_72_avg,res)
p0=gsn_csm_contour(wks,diurnal_windt_36_72_avg,resc)
overlay(plot(0), p0)
res@tiMainString="~F25~(b) DAY-CTRL (36-72h)"
res@tiXAxisOn=True
res@tmXBLabelsOn=True
res@tiMainOffsetYF=0
gsn_define_colormap(wks,"MPL_bwr");MPL_bwr
plot(1)=gsn_csm_contour(wks,day_windr_36_72_avg-diurnal_windr_36_72_avg,res)
resc@cnMinLevelValF=-3.0
resc@cnLevelSpacingF=0.5
resc@cnMaxLevelValF=3.0
resc@gsnContourNegLineDashPattern = 1 
p1=gsn_csm_contour(wks,day_windt_36_72_avg-diurnal_windt_36_72_avg,resc)
overlay(plot(1), p1)
res@tiMainString="~F25~(c) NIGHT-CTRL (36-72h)"
plot(2)=gsn_csm_contour(wks,night_windr_36_72_avg-diurnal_windr_36_72_avg,res)
p2=gsn_csm_contour(wks,night_windt_36_72_avg-diurnal_windt_36_72_avg,resc)
overlay(plot(2), p2)
resall=True
resall@gsnMaximize=True
resall@gsnPanelDebug     = True     ; To get information from panel
gsn_panel(wks,plot,(/1,3/),resall)
