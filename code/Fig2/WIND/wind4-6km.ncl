ensemble="ens2"
sen_exp="noon"
filenn="ls /mnt/f/120km/"+ensemble+"/"+sen_exp+"/wrfout_d03*"
files=systemfunc(filenn)
f=addfiles(files,"r")
print(f)
len=96
start=0
y=ispan(0,len-1,1)
minx=asciiread("../../minxy/"+sen_exp+"_4000_"+ensemble+"_x", (/len/), "integer")
miny=asciiread("../../minxy/"+sen_exp+"_4000_"+ensemble+"_y", (/len/), "integer")
lat=ispan(0,598,2)
lon=ispan(0,598,2)
nlat=300
nlon=300
lat2d=onedtond(lat,(/nlat,nlon/))
lat2d:=transpose(lat2d)
lat2d:=ndtooned(lat2d)
lon2d=onedtond(lon,(/300*300/))
rn=81
tn=10
x00=minx*2.0
y00=miny*2.0
pi=3.14159265
theta=ispan(0,360-1,360/tn)
xo=new((/rn,tn/),float)
yo=new((/rn,tn/),float)
uoutput_1d=new((/len,rn*tn/),float)
voutput_1d=new((/len,rn*tn/),float)
data_u=new((/5,300,300/),float)
data_v=new((/5,300,300/),float)
do z=0,len-1
print(z)
U_full=wrf_user_getvar(f,"ua",start+z)
V_full=wrf_user_getvar(f,"va",start+z)
height=wrf_user_getvar(f,"z",start+z)
do lev=0,4
data_u(lev,:,:) = wrf_user_intrp3d(U_full,height,"h",4000+lev*500,0.,False)
data_v(lev,:,:) = wrf_user_intrp3d(V_full,height,"h",4000+lev*500,0.,False)
end do
U = dim_avg_n(data_u,0)
V = dim_avg_n(data_v,0)
do i=0,rn-1
xo(i,:)=x00(z)+i*sin(theta*pi/180)*2.0
yo(i,:)=y00(z)+i*cos(theta*pi/180)*2.0
end do
xo2d=ndtooned(xo)
yo2d=ndtooned(yo)
uwnd2d=ndtooned(U(:,:))
vwnd2d=ndtooned(V(:,:))
uoutput_1d(z,:)= dspnt2( lat2d , lon2d,uwnd2d, xo2d, yo2d)
voutput_1d(z,:)= dspnt2( lat2d,lon2d , vwnd2d, xo2d, yo2d)
end do

uoutput_3d=reshape(output_1d,(/len,rn,tn/))
voutput_3d=reshape(voutput_1d,(/len,rn,tn/))
data_ave=new((/len,rn/),float)
do i=0,len-1
do j=0,rn-1
data_ave(i,j)=avg(voutput_3d(i,j,:)*cos(theta*pi/180)-output_3d(i,j,:)*sin(theta*pi/180))
end do
end do
asciiwrite("WIND4-6km_"+sen_exp+"_"+data_ave,aave)