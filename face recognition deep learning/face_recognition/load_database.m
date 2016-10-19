function out=load_database();
% We load the database the first time we run the program.

persistent ld;          %ld is a flag, if the program detact that the value for loaded is 1
                            %it will not load the program again
persistent w;
if(isempty(ld))         %ld database
    v=zeros(10304,400);
    for i=1:40
        cd(strcat('s',num2str(i)));
        for j=1:10
            a=imread(strcat(num2str(j),'.pgm'));
            v(:,(i-1)*10+j)=reshape(a,size(a,1)*size(a,2),1);
        end
        cd ..
    end
    w=uint8(v); % Convert to unsigned 8 bit numbers to save memory. 
end
ld=1;  % Set 'ld' flag to aviod loading the database again. 
out=w;