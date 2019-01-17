clc;
d_simplified = sym(zeros(size(D)));
limit=60;
%%%%1s
for i=1:length(d)
    for j=i:length(d)
%         disp('m1')
%         disp([i j])
%         tic
        d_simplified(i,j) = m1*simplify(diff(D(i,j),m1),limit);
%         toc
%         disp('------------------')
    end
end
for i=1:length(d)
    for j=i:length(d)
%         disp('I1')
%         disp([i j])
%         tic
%         d_simplified(i,j) =d_simplified(i,j)+ I1*simplify(diff(D(i,j),I1),limit);
        toc
%         disp('------------------')
    end
end

%%%%2s
for i=1:length(d)
    for j=i:length(d)
%         disp('m2')
%         disp([i j])
%         tic
        d_simplified(i,j) = d_simplified(i,j) + m2*simplify(diff(D(i,j),m2),limit);
%         toc
%         disp('------------------')
    end
end
for i=1:length(d)
    for j=i:length(d)
%         disp('I2')
%         disp([i j])
%         tic
        d_simplified(i,j) = d_simplified(i,j) + I2*simplify(diff(D(i,j),I2),limit);
%         toc
%         disp('------------------')
    end
end

fid = fopen('dmatrixWork12GB.txt', 'w');
for i=1:length(d)
    for j=i:length(d)
        fprintf(fid,'%%D%d%d\r\n\r\n',i,j);
        s = char(d_simplified(i,j));
        fprintf(fid,'%s\r\n\r\n', s);
    end
end
fclose(fid);

fid = fopen('dmatrix4Work12GB.txt', 'w');
for i=1:length(d)
    for j=1:length(d)
        fprintf(fid,'%%D%d_%d\r\n\r\n',i,j);
        s = char(d_simplified(i,j));
        fprintf(fid,'%s\r\n\r\n', s);
    end
end
fclose(fid);