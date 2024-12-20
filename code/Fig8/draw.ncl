data_night=asciiread("CFAD160nightavg.dat",(/36,81,61/),"float")
data_day=asciiread("CFAD160noonavg.dat",(/36,81,61/),"float")
data_diurnal=asciiread("CFAD160diurnalavg.dat",(/36,81,61/),"float")
wks  = gsn_open_wks("eps", "Fig_8")
plot = new(3,graphic) 
result_night=dim_avg_n_Wrap(data_night(0:35,:,:),0)*100
result_day=dim_avg_n_Wrap(data_day(0:35,:,:),0)*100
result_diurnal=dim_avg_n_Wrap(data_diurnal(0:35,:,:),0)*100
res=True
res@gsnDraw      =  False                   ; do not draw the plot
res@gsnFrame     =  False  
res@vpWidthF      = 0.6
res@vpHeightF     = 0.8
res@cnLevelSelectionMode = "ExplicitLevels"   ; set explicit contour levels
res@cnLevels    = (/ 30,15,5,2,1,0.5,0.1/)   ; set levels
res@tmXBMajorOutwardLengthF = -0.001
res@tmXBMinorOutwardLengthF = -0.001
res@tmYLMajorOutwardLengthF = -0.001
res@tmYLMinorOutwardLengthF = -0.001
res@tmYRMajorOutwardLengthF = -0.001
res@tmYRMinorOutwardLengthF = -0.001
res@tmYLMode="Explicit"
res@tmYLValues=(/0,10,20,30,40,50,60/)
res@tmYLMinorValues = ispan(0,60,2)
res@tmYLLabels=(/"~F25~0","~F25~2","~F25~4","~F25~6","~F25~8","~F25~10","~F25~12"/)
res@cnFillOn    = True                        ; turn on color fill
res@cnLinesOn   = False                       ; turn off the contour lines
res@tmXBMode="Explicit"
res@tmXBValues=(/0,10,20,30,40,50,60,70,80/)
res@tmXBMinorValues = ispan(0,80,2)
res@cnLineLabelsOn=False
res@tiXAxisString="~F25~Vertical Velocity (m/s)"
res@tmXBLabels=(/"~F25~-2","~F25~-1.5","~F25~-1","~F25~-0.5","~F25~0","~F25~0.5","~F25~1","~F25~1.5","~F25~2"/)
res@tiMainString="~F25~(b) CTRL"
res@lbOrientation            = "Vertical"
res@cnInfoLabelOn       = False
res@gsnContourNegLineDashPattern = 1
resc=True
resc@gsnDraw      =  False                   ; do not draw the plot
resc@gsnFrame     =  False  
resc@cnLineThicknessF=2
resc@cnMonoLineColor=False
resc@cnLineColors=(/"Black","Black"/)
resc@cnLevelSelectionMode = "Explicitlevels"
resc@cnLevels=(/-0.05,0.05/)
resc@cnInfoLabelOn=False
resc@cnLineLabelsOn=False
resc@gsnContourNegLineDashPattern = 1 
plot(1)=gsn_csm_contour(wks, transpose(result_diurnal), res)
res@tiMainString="~F25~(c) DAY"
res@lbLabelBarOn        = True
plot(2)=gsn_csm_contour(wks, transpose(result_day), res)
plott=gsn_csm_contour(wks, transpose(result_day-result_diurnal),resc)
overlay(plot(2),plott) 
res@tiMainString="~F25~(a) NIGHT "
res@tiYAxisString="~F25~Height (km)"
;res@lbLabelBarOn        = False
plot(0)=gsn_csm_contour(wks, transpose(result_night), res)
plottt=gsn_csm_contour(wks, transpose(result_night-result_diurnal), resc)
overlay(plot(0),plottt) 
resss=True
resss@gsnMaximize = True
resss@gsnPanelMainFont  = 22
gsn_define_colormap(wks,"WhiteBlueGreenYellowRed")
gsn_panel(wks,plot,(/1,3/),resss)