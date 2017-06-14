function [FRI,CHG]=filter_directly_decrypt_image4(RI,thres,permutation_key,encryption_key,u,v,msb,level)
    [m,n]=size(RI);
    FRI=RI;
    neighbour=[-1 -1;-1 0;-1 1;0 -1;0 1;1 -1;1 0;1 1];
%     neighbour=[1 0;0 1;0 -1;-1 0]; 
    [ser1 ser2]=size(neighbour);
    CHG=false;
    for i=1:m
        for j=1:n
            cur=RI(i,j);
%             if cur==0 || cur==255
            if (cur>=0 && cur<=level*2) || (cur>=255-level*2 && cur<=255)
                low=0;
                high=0;
               for k=1:ser1
                  ni=i+neighbour(k,1);
                  nj=j+neighbour(k,2);
                  if ni>=1 && ni<=m && nj>=1 && nj<=n
                      cur_nei=RI(ni,nj);
                      if cur_nei~=0 && cur_nei~=1 
                         if cur_nei>127
                             high=high+1;
                         else
                             low=low+1;
                         end
                      end
                  end
               end
               
               if low>high && cur>=255-level*2 && cur<=255
                   cur=level*2;
                   CHG=true;
               end
               if low<high && cur>=0 && cur<=level*2
                   cur=255-level*2;
                   CHG=true;
               end
            end
            FRI(i,j)=cur;
        end
    end
end