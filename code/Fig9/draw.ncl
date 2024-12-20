files=systemfunc("ls  ../../chap3/diurnal/ens0/wrfout_d03*")
f=addfiles(files,"r")
time=66
eth=wrf_user_getvar(f,"eth",time)
eth_low=eth(0:6,:,:)
eth_low=eth_low-avg(eth_low)
eth_avg = dim_avg_n( eth_low, 0 )
ua=wrf_user_getvar(f,"ua",time)
ua_low=ua(0:6,:,:)
ua_avg = dim_avg_n( ua_low, 0 )
va=wrf_user_getvar(f,"va",time)
va_low=va(0:6,:,:)
va_avg = dim_avg_n( va_low, 0 )
wa=wrf_user_getvar(f,"wa",time)
wa_low=wa(0:6,:,:)
wa_avg = dim_avg_n( wa_low, 0 )
;end do
res=True
res@trXMaxF=225
res@trYMaxF=225
res@trXMinF=75
res@trYMinF=75
;res@gsnDraw=False
;res@gsnFrame=False
res@tmXBMajorOutwardLengthF = -0.001
res@tmXBMinorOutwardLengthF = -0.001
res@tmYLMajorOutwardLengthF = -0.001
res@tmYLMinorOutwardLengthF = -0.001
res@tmYRMajorOutwardLengthF = -0.001
res@tmYRMinorOutwardLengthF = -0.001
res@tmXBMode="Explicit"
res@tmXBValues=(/75,100,125,150,175,200,225/)
res@tmXBMinorValues = ispan(0,300,5)
res@tmXBLabels=(/"~F25~-150","~F25~-100","~F25~-50","~F25~0","~F25~50","~F25~100","~F25~150"/)
res@tmYLMode="Explicit"
res@tmYLValues=(/75,100,125,150,175,200,225/)
res@tmYLMinorValues = ispan(0,300,5)
res@tmYLLabels=(/"~F25~-150","~F25~-100","~F25~-50","~F25~0","~F25~50","~F25~100","~F25~150"/)
ress=res
ress@cnLevelSelectionMode = "Explicitlevels"
ress@gsnContourNegLineDashPattern = 1 
ress@cnMonoLineColor=False
ress@cnLineColors=(/"green","purple"/)
ress@cnLevels=(/-0.2,0.2/)
ress@cnLineThicknessF=2.5
res@cnFillOn=True
res@cnLineLabelsOn=False
res@cnLinesOn=False
res@cnLevelSelectionMode = "ManualLevels"
res@cnMinLevelValF=-14
res@cnLevelSpacingF=2
res@cnMaxLevelValF=14
res@gsnFrame=False
res@lbOrientation="vertical"
res_vector=False
wks  = gsn_open_wks("eps", "diurnal_anomaly"+tostring(start))
res@cnFillPalette="NCV_blue_red"
plot=gsn_csm_contour(wks,eth_avg,res)
gsres=True
gsres@gsMarkerIndex=16
gsres@gsMarkerSizeF=0.008
gsres@gsMarkerColor="black"
counter=0
do i=75,225
do j=75,225
if (wa_avg(i,j).gt.0.5)
gsn_polymarker(wks,plot,j,i,gsres)
counter=counter+1
end if
end do
end do
;plot1=gsn_csm_contour(wks,wa_avg,ress)
;overlay(plot, plot1)