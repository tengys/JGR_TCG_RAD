ensemble="ens2"
sen_exp=(/"diurnal","night","noon"/)
do sen_step=0,2
print(sen_exp(sen_step))
len=96
start=0
y=ispan(0,len-1,1)
;vwnd=f[:]->V10
minx=asciiread("../../minxy/"+sen_exp(sen_step)+"_4000_"+ensemble+"_x", (/len/), "integer")
miny=asciiread("../../minxy/"+sen_exp(sen_step)+"_4000_"+ensemble+"_y", (/len/), "integer")
avo=asciiread("avo4-6km_"+sen_exp(sen_step)+"_"+ensemble, (/len,300,300/), "integer")
out=new((/len/),float)
out=0.
do time=0,len-1
counter=0
print(time)
do i=40,260
do j=40,260
if((i-minx(time))*(i-minx(time))+(j-miny(time))*(j-miny(time)).lt.6400)
counter=counter+1
out(time-start)=out(time-start)+(avo(time,i,j)-out(time-start))/counter
end if
end do
end do


end do
asciiwrite("avo_time_"+sen_exp(sen_step)+"4-6km_160km_"+ensemble+".dat", out)
end do