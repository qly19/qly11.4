[a,R]=geotiffread('D:\7-��ҵ��������-������\QLY\QLY-6.10����\6-ͼ3 ƫ���\8-ƫ�����������\1-��ˮ\pre1982');%�ȵ���ͶӰ��Ϣ��ĳ��Ӱ���·�����У������������������е�һ����
info=geotiffinfo('D:\7-��ҵ��������-������\QLY\QLY-6.10����\6-ͼ3 ƫ���\8-ƫ�����������\1-��ˮ\pre1982');%ͬ��
[m,n]=size(a);
nppsum=zeros(m*n,39);%�˴�Ҫ�޸ģ����������д���٣���������8���
for year=1982:2020
    filename=strcat('D:\7-��ҵ��������-������\QLY\QLY-6.10����\6-ͼ3 ƫ���\8-ƫ�����������\1-��ˮ\pre',int2str(year),'.tif');%�˴�Ҫ�޸ģ��������ǰ����ÿ�����ֲ�����Ƕȵ����ݣ�ע������ļ����֡�
    data=importdata(filename);
    data=reshape(data,m*n,1);
    nppsum(:,year-1981)=data;%�˴���Ҫ�޸ģ��ҵ������Ǵ�2013��ʼ���˴���Ϊ2012.
end
wcsum=zeros(m*n,39);
for year=1982:2020
    filename=strcat('D:\7-��ҵ��������-������\QLY\QLY-6.10����\6-ͼ3 ƫ���\8-ƫ�����������\4-NDVI\NDVImax',int2str(year),'_Resample1.tif');%�˴�Ҫ�޸ģ��������ǰ����ÿ������ر��¶ȵ����ݣ�ע������ļ����֡�
    data=importdata(filename);
    data=reshape(data,m*n,1);
    wcsum(:,year-1981)=data;
end
%����Ժ�������
npp_wc_xgx=zeros(m,n);
npp_wc_p=zeros(m,n);
for i=1:length(nppsum)
    npp=nppsum(i,:);
    if min(npp)>0 %ע�������NPP����Ч��Χ�Ǵ���0������Լ���������Ч��Χ��С��0�Ļ�������Բ��ü����
        wc=wcsum(i,:);
         [r2,p2]=corrcoef(npp,wc);
         npp_wc_xgx(i)=r2(2);
         npp_wc_p(i)=p2(2);
    end
end
filename5='D:\7-��ҵ��������-������\QLY\QLY-10.8����\1-ͼ1�����\1-ͼ\�����_P_NDVI.tif';%�˴�Ҫ�޸ģ������·��������
filename6='D:\7-��ҵ��������-������\QLY\QLY-10.8����\1-ͼ1�����\1-ͼ\������_P_NDVI.tif';%ͬ��
geotiffwrite(filename5,npp_wc_xgx,R,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);
geotiffwrite(filename6,npp_wc_p,R,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);