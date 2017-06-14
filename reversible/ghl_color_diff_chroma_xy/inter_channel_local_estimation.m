                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       function [c3]=inter_channel_local_estimation(c1,c2,C1,C2,C3,M,N)
    % estimate c3 according to c1,c2 and corresponding
    % four-pixel(diagonal) neighbourhood C1,C2 using C3
    
    % use Nearest-N-percent of distance-closest neighbourhood pixels to estimate
%     dist=((C1-c1).^2+(C2-c2).^2).^0.5;
%     min_dist=min(dist);
%     upper_limit_dist=(1+N/100)*min_dist;
%     ind=find(dist<=upper_limit_dist);

    
    % use Nearest-N-percent of angluar-closest neighbourhood pixels to estimate
%     if c1==0 && c2==0
%         c3=mean(C3);
%         return
%     end
%     
%     n=numel(C1);
%     angle=ones(n,1)*180;
%     for i=1:n
%         if C1(i)==0 && C2(i)==0
%             continue;
%         end
%         angle(i)=acosd((C1(i)*c1+C2(i)*c2)/sqrt(c1^2+c2^2)/sqrt(C1(i)^2+C2(i)^2));
%     end
%     
%     min_angle=min(angle);
% 
%     upper_limit_angle=N+min_angle;
%     ind=find(angle<=upper_limit_angle);
%     
% 
%     NC1=C1(ind);
%     NC2=C2(ind);
%     NC3=C3(ind);
%     [c3]=estimate_c3(NC1,NC2,NC3,c1,c2);
    
%  M=[	
%  0.4124564  0.3575761  0.1804375
%  0.2126729  0.7151522  0.0721750
%  0.0193339  0.1191920  0.9503041];
% temp_M=M;
% [~,order]=sort(N);% N用于确定通道间插值方式 N=[1 2 3]表示顺序为R G B
% for i=1:3
%     M(:,i)=temp_M(:,order(i));
% end
m11=M(1,1);m12=M(1,2);m13=M(1,3);
m21=M(2,1);m22=M(2,2);m23=M(2,3);
m31=M(3,1);m32=M(3,2);m33=M(3,3);

    c1=im2double(uint8(c1));
    c2=im2double(uint8(c2));
    C1=im2double(uint8(C1));
    C2=im2double(uint8(C2));
    C3=im2double(uint8(C3));
    
    num=numel(C1);
    RGB_mat=zeros(num,3);
    XYZ_mat=zeros(num,3);
    for i=1:num
        RGB_mat(i,:)=[C1(i),C2(i),C3(i)];
        XYZ_mat(i,:)=my_rgb2xyz(RGB_mat(i,:),M);
        XYZ_mat(i,:)=XYZ_mat(i,:)/sum(XYZ_mat(i,:));
    end
    % 不考虑z
    XYZ_mat(:,3)=0;

       kx=m13;ky=m23;kz=m33;
       lx=m11*c1+m12*c2;ly=m21*c1+m22*c2;lz=m31*c1+m32*c2;
       
       pointx=kx/(kx+ky+kz);pointy=ky/(kx+ky+kz);
%        pointz=kz/(kx+ky+kz);
       pointz=0;
       % 归一化,直线过该点，现在只考虑xy，不考虑z
%        xl=kx;yl=ky;zl=kz;
       point=[pointx,pointy,pointz];
       
       linex=lx-kx*(lx+ly+lz)/(kx+ky+kz);
       liney=ly-ky*(lx+ly+lz)/(kx+ky+kz);
%        linez=lz-kz*(lx+ly+lz)/(kx+ky+kz);
       % 现在只考虑xy，不考虑z
       linez=0;
       
       line=[linex,liney,linez];% 直线的方向
       
    dist=-ones(num,1);
    t=zeros(num,1);
    cur_c3=zeros(num,1);
    for i=1:num        
            dist(i)=norm(cross(point-XYZ_mat(i,:),line))/norm(line);% 空间内点到直线的距离（实际上应该是线段）
            xyz0=XYZ_mat(i,:);
            t(i)=line*(xyz0-point)'/(linex^2+liney^2+linez^2);% 点到直线的垂点的参数t
            cur_c3(i)=(1/t(i)-lx-ly-lz)/(kx+ky+kz);
            if cur_c3(i)<0 || cur_c3(i)>1 % 实际取不到的c3,需要在线段的端点取可能的最小值，更改对应的距离
                cur_c3(i)=double(im2uint8(cur_c3(i)));
                end_x=kx*cur_c3(i)+lx;
                end_y=ky*cur_c3(i)+ly;
                end_z=kz*cur_c3(i)+lz;
                end_point=[end_x/(end_x+end_y+end_z),end_y/(end_x+end_y+end_z),end_z/(end_x+end_y+end_z)];
                dist(i)=norm(end_point-XYZ_mat(i,:));
            else % 实际可以取到的c3，但是c3要求是整数，所以要尝试转换得到的整数c3和其相邻两个整数。
                dist_cur=dist(i);
                tmp_c3=double(im2uint8(cur_c3(i)));
                
                if tmp_c3==0
                    cur_c3_low=0;
                    dist_low=dist_cur;
                else
                    cur_c3_low=tmp_c3-1;% 如果tmp_c3为50，50-1=49
                    double_cur_c3_low=im2double(uint8(cur_c3_low));
                    end_x=kx*double_cur_c3_low+lx;                
                    end_y=ky*double_cur_c3_low+ly;
                    end_z=kz*double_cur_c3_low+lz;
                    end_point=[end_x/(end_x+end_y+end_z),end_y/(end_x+end_y+end_z),end_z/(end_x+end_y+end_z)];
                    dist_low=norm(end_point-XYZ_mat(i,:));
                end
                    
                if tmp_c3==255
                    cur_c3_high=255;
                    dist_high=dist_cur;
                else
                    cur_c3_high=tmp_c3+1;% 如果tmp_c3为50，50+1=51
                    double_cur_c3_high=im2double(uint8(cur_c3_high));
                    end_x=kx*double_cur_c3_high+lx;                
                    end_y=ky*double_cur_c3_high+ly;
                    end_z=kz*double_cur_c3_high+lz;
                    end_point=[end_x/(end_x+end_y+end_z),end_y/(end_x+end_y+end_z),end_z/(end_x+end_y+end_z)];
                    dist_high=norm(end_point-XYZ_mat(i,:));
                end
                % 取三个距离中最小的
                dist_arr=[dist_cur,dist_low,dist_high];
                cur_c3_arr=[tmp_c3,cur_c3_low,cur_c3_high];
                [~,ind]=sort(dist_arr);
                cur_c3(i)=cur_c3_arr(ind(1));
            end
            
            
    end
%     cur_c3
%     dist
    [~,ind]=sort(dist);
    c3=cur_c3(ind(1));
end