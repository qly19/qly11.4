[a,R]=geotiffread('D:\7-毕业论文数据-曾海峻\QLY\QLY-10.9分析\1-气象数据\2-温度\tmp1982');%先导入投影信息
info=geotiffinfo('D:\7-毕业论文数据-曾海峻\QLY\QLY-10.9分析\1-气象数据\2-温度\tmp1982');
[m,n]=size(a);
cd=2020-1982+1;%时间跨度，根据需要自行修改
datasum=zeros(m*n,cd)+NaN; 
k=1;
for year=1982:2020 %起始年份
    filename=['D:\7-毕业论文数据-曾海峻\QLY\QLY-10.9分析\1-气象数据\2-温度\tmp',int2str(year),'.tif'];
    data=importdata(filename);
    data=reshape(data,m*n,1);
    datasum(:,k)=data;
    k=k+1;
end
result=zeros(m,n)+NaN;
for i=1:size(datasum,1)
    data=datasum(i,:);
    if min(data)>-100 %判断是否是有效值,我这里的有效值必须大于0
        valuesum=[];
        for k1=2:cd
            for k2=1:(k1-1)
                cz=data(k1)-data(k2);
                jl=k1-k2;
                value=cz./jl;
                valuesum=[valuesum;value];
            end
        end
        value=median(valuesum);
        result(i)=value;
    end
end
filename=['D:\7-毕业论文数据-曾海峻\QLY\QLY-10.9分析\2-sen趋势分析\1-matlab\温度年际变化趋势.tif'];
geotiffwrite(filename,result,R,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag)