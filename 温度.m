[a,R]=geotiffread('D:\7-��ҵ��������-������\QLY\QLY-10.9����\1-��������\2-�¶�\tmp1982');%�ȵ���ͶӰ��Ϣ
info=geotiffinfo('D:\7-��ҵ��������-������\QLY\QLY-10.9����\1-��������\2-�¶�\tmp1982');
[m,n]=size(a);
cd=2020-1982+1;%ʱ���ȣ�������Ҫ�����޸�
datasum=zeros(m*n,cd)+NaN; 
k=1;
for year=1982:2020 %��ʼ���
    filename=['D:\7-��ҵ��������-������\QLY\QLY-10.9����\1-��������\2-�¶�\tmp',int2str(year),'.tif'];
    data=importdata(filename);
    data=reshape(data,m*n,1);
    datasum(:,k)=data;
    k=k+1;
end
result=zeros(m,n)+NaN;
for i=1:size(datasum,1)
    data=datasum(i,:);
    if min(data)>-100 %�ж��Ƿ�����Чֵ,���������Чֵ�������0
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
filename=['D:\7-��ҵ��������-������\QLY\QLY-10.9����\2-sen���Ʒ���\1-matlab\�¶���ʱ仯����.tif'];
geotiffwrite(filename,result,R,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag)