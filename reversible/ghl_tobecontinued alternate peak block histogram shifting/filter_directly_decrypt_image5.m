function [FRI]=filter_directly_decrypt_image5(RI,thres,permutation_key,encryption_key,u,v,msb,level)
[m,n]=size(RI);
RI=double(RI);
FRI=RI;

[x_good,y_good]=find_good_pixel(RI,level);
visited=zeros(m,n);



if ~isempty(x_good)
    queue_head=1;       %队列头
    queue_tail=1;       %队列尾
    q=cell(numel(x_good),1);
    for i=1:numel(x_good)
        visited(x_good(i),y_good(i))=1;
        q{queue_tail}=[x_good(i) y_good(i)];
        queue_tail=queue_tail+1;
    end
%     neighbour=[-1 -1;-1 0;-1 1;0 -1;0 1;1 -1;1 0;1 1];  %和当前像素坐标相加得到八个邻域坐标
    neighbour=[1 0;0 1;0 -1;-1 0];     %四邻域用的
    
    [ser1 ser2]=size(neighbour);
    while queue_head~=queue_tail
        pxl=q{queue_head};
        x_base=pxl(1);
        y_base=pxl(2);
        base=RI(x_base,y_base);
        for i=1:ser1
            adjpxl=pxl+neighbour(i,:);
            x_cur=adjpxl(1);
            y_cur=adjpxl(2);
            if x_cur>=1 && y_cur>=1 && x_cur<=m && y_cur<=n && visited(x_cur,y_cur)==0
                cur=RI(x_cur,y_cur);
                if cur<=level*2 && base>127
                    cur=255-level*2;
                else if cur>=255-level*2 && base<=127
                    cur=level*2;
                    end
                end
                FRI(x_cur,y_cur)=cur;
                q{queue_tail}=[x_cur y_cur];
                queue_tail=queue_tail+1;
                visited(x_cur,y_cur)=1;
            end
        end
        
        queue_head=queue_head+1;
    end



end