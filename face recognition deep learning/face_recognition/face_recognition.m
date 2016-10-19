% Face recognition Final Project for Computer Vision
% This algorithm uses the eigenface system (based on principal component
% analysis - PCA) to recognize faces. The corresponding paper is here:
% http://www.face-rec.org/algorithms/PCA/jcn.pdf
% Download the face database. For me, I used the orl_faces database.
% http://www.cl.cam.ac.uk/research/dtg/attarchive/facedatabase.html is
% the plase for the database. Here I use 400 pictures for human face. The
% database contains 400 pictures of 40 subjects. 


Fter=load_database(); % Loading the database into matrix v

% (1)Initializations
% Randomly pick an image from our database and use the rest of the
% images for training. Training is done on 399 pictues. We later
% use the randomly selectted picture to test the algorithm.

Ind=round(400*rand( 1,1));            % Randomly pick an index.
r=Fter(:,Ind);                          % r contains the image we later on will use to test the algorithm
                                   
v=Fter(:,[1:Ind-1 Ind+1:end]);           % v contains the rest of the 399 images. 

N=20;                               % Number of signatures used for each image.
% Subtracting the mean from v
O=uint8(ones(1,size(v,2))); 
m=uint8(mean(v,2));                         % m is the mean of all images.
v_nomean=v-uint8(single(m)*single(O));   % v_nomean is v with the mean removed. 

% Calculating eignevectors of the correlation matrix

L=single(v_nomean)'*single(v_nomean); % Pick N of the 400 eigenfaces.
[V,D]=eig(L);
V=single(v_nomean)*V;
V=V(:,end:-1:end-(N-1));            % Pick the eignevectors corresponding to the 10 largest eigenvalues. 


% Calculating the signature for each image
cv=zeros(size(v,2),N);
for i=1:size(v,2);
    cv(i,:)=single(v_nomean(:,i))'*V;    % Each row in cv is the signature for one image.
end


% (2)Recognition 
%  In this step we test the algorithm to find out if we can recognize the corresponding face 
subplot(121); 
imshow(reshape(r,112,92));title('Detect this face ...','FontWeight','bold','Fontsize',18,'color','red');

subplot(122);
p=r-m;                              % Subtract the mean
s=single(p)'*V;
z=[];
for i=1:size(v,2)
    z=[z,norm(cv(i,:)-s,2)];
    if(rem(i,20)==0),imshow(reshape(v(:,i),112,92)),end;
    drawnow;
end

[a,i]=min(z);
subplot(122);
imshow(reshape(v(:,i),112,92));title('This is the guy!','FontWeight','bold','Fontsize',18,'color','green');


