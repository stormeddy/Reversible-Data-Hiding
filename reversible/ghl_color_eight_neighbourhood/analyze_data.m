single_channel_ratio_ucid=ratio_ucid;
single_channel_psnr_ucid=psnr_ucid;

riwuit_ratio_ucid=ratio_ucid(:,4:6);
riwuit_psnr_ucid=psnr_ucid(:,4:6);

save('single_channel_ratio_ucid.mat','single_channel_ratio_ucid');
save('single_channel_psnr_ucid.mat','single_channel_psnr_ucid');
save('riwuit_ratio_ucid.mat','riwuit_ratio_ucid');
save('riwuit_psnr_ucid.mat','riwuit_psnr_ucid');

riwuit_cannot_embed_ind1=find(riwuit_ratio_ucid(:,1)<=0);
riwuit_cannot_embed_ind2=find(riwuit_ratio_ucid(:,2)<=0);
riwuit_cannot_embed_ind3=find(riwuit_ratio_ucid(:,3)<=0);
riwuit_cannot_embed_ind_all=union(riwuit_cannot_embed_ind1,union(riwuit_cannot_embed_ind2,riwuit_cannot_embed_ind3));


higher_ind1=find(single_channel_ratio_ucid(:,1)>riwuit_ratio_ucid(:,1));
higher_ind2=find(single_channel_ratio_ucid(:,2)>riwuit_ratio_ucid(:,2));
higher_ind3=find(single_channel_ratio_ucid(:,3)>riwuit_ratio_ucid(:,3));
higher_ind_all=union(higher_ind1,union(higher_ind2,higher_ind3));
lower_ind_all=setdiff([1:1338]',higher_ind_all);


diff=single_channel_ratio_ucid-riwuit_ratio_ucid;
[max_diff,max_ind]=max(diff,[],2);

num1=numel(find(max_ind==1));
num2=numel(find(max_ind==2));
num3=numel(find(max_ind==3));