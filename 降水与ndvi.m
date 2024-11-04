[a,R]=geotiffread('D:\7-毕业论文数据-曾海峻\QLY\QLY-6.10分析\6-图3 偏相关\8-偏相关气象数据\1-降水\pre1982');%先导入投影信息，某个影像的路径就行（最好是你分析的数据中的一个）
info=geotiffinfo('D:\7-毕业论文数据-曾海峻\QLY\QLY-6.10分析\6-图3 偏相关\8-偏相关气象数据\1-降水\pre1982');%同上
[m,n]=size(a);
nppsum=zeros(m*n,39);%此处要修改，共几年就填写多少，我这里是8年的
for year=1982:2020
    filename=strcat('D:\7-毕业论文数据-曾海峻\QLY\QLY-6.10分析\6-图3 偏相关\8-偏相关气象数据\1-降水\pre',int2str(year),'.tif');%此处要修改，我这里是八年的每年年均植被覆盖度的数据，注意你的文件名字。
    data=importdata(filename);
    data=reshape(data,m*n,1);
    nppsum(:,year-1981)=data;%此处需要修改，我的数据是从2013开始，此处就为2012.
end
wcsum=zeros(m*n,39);
for year=1982:2020
    filename=strcat('D:\7-毕业论文数据-曾海峻\QLY\QLY-6.10分析\6-图3 偏相关\8-偏相关气象数据\4-NDVI\NDVImax',int2str(year),'_Resample1.tif');%此处要修改，我这里是八年的每年年均地表温度的数据，注意你的文件名字。
    data=importdata(filename);
    data=reshape(data,m*n,1);
    wcsum(:,year-1981)=data;
end
%相关性和显著性
npp_wc_xgx=zeros(m,n);
npp_wc_p=zeros(m,n);
for i=1:length(nppsum)
    npp=nppsum(i,:);
    if min(npp)>0 %注意这里的NPP的有效范围是大于0，如果自己的数据有效范围有小于0的话，则可以不用加这个
        wc=wcsum(i,:);
         [r2,p2]=corrcoef(npp,wc);
         npp_wc_xgx(i)=r2(2);
         npp_wc_p(i)=p2(2);
    end
end
filename5='D:\7-毕业论文数据-曾海峻\QLY\QLY-10.8分析\1-图1简单相关\1-图\相关性_P_NDVI.tif';%此处要修改，输出的路径及名字
filename6='D:\7-毕业论文数据-曾海峻\QLY\QLY-10.8分析\1-图1简单相关\1-图\显著性_P_NDVI.tif';%同上
geotiffwrite(filename5,npp_wc_xgx,R,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);
geotiffwrite(filename6,npp_wc_p,R,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);