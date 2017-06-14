function [FRI]=filter_directly_decrypt_image3(RI,thres,permutation_key,encryption_key,u,v,msb,level)
[m,n]=size(RI);
RI=double(RI);
FRI=RI;


hor_num=floor(m/u);
ver_num=floor(n/v);

[x_good,y_good]=find_good_block(RI,u,v,level);
visited=zeros(hor_num,ver_num);
visited(x_good,y_good)=1;

if x_good~=0 && y_good~=0
    queue_head=1;       %队列头
    queue_tail=1;       %队列尾
%     neighbour=[-1 -1;-1 0;-1 1;0 -1;0 1;1 -1;1 0;1 1];  %和当前像素坐标相加得到八个邻域坐标
    neighbour=[1 0;0 1;0 -1;-1 0];     %四邻域用的
    q{queue_tail}=[x_good y_good];
    queue_tail=queue_tail+1;
    [ser1 ser2]=size(neighbour);
    while queue_head~=queue_tail
        blk=q{queue_head};
        x_base_cur=blk(1);
        y_base_cur=blk(2);
        base_blk=FRI((x_base_cur-1)*u+1:x_base_cur*u,(y_base_cur-1)*v+1:y_base_cur*v);
        for i=1:ser1
            adjblk=blk+neighbour(i,:);
            x_cur=adjblk(1);
            y_cur=adjblk(2);
            if x_cur>=1 && y_cur>=1 && x_cur<=hor_num && y_cur<=ver_num && visited(x_cur,y_cur)==0
                cur_blk=RI((x_cur-1)*u+1:x_cur*u,(y_cur-1)*v+1:y_cur*v);
                [judge,zero,full]=contains_jump(cur_blk,level);
                if judge
                    [lower]=is_lower(base_blk);
                    if lower
                        cur_blk(full)=0+level*2;
                    else
                        cur_blk(zero)=255-level*2;
                    end
                    FRI((x_cur-1)*u+1:x_cur*u,(y_cur-1)*v+1:y_cur*v)=cur_blk;
                    
                    
                end
                q{queue_tail}=[x_cur y_cur];
                queue_tail=queue_tail+1;
                visited(x_cur,y_cur)=1;
            end
        end
        
        queue_head=queue_head+1;
    end
end


end