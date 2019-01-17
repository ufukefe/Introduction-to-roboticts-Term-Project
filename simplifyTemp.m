clc;
C_simplified = sym(zeros(size(C)));
limit=30;
for k=1:length(d)
%%%%1s
for i=1:length(d)
    for j=i:length(d)
%         disp('m1')
%         disp([i j k])
%         tic
        C_simplified(i,j,k) = m1*simplify(diff(C(i,j,k),m1),limit);
%         toc
%         disp('------------------')
    end
end
for i=1:length(d)
    for j=i:length(d)
%         disp('I1')
%         disp([i j k])
%         tic
        C_simplified(i,j,k) =C_simplified(i,j,k)+ I1*simplify(diff(C(i,j,k),I1),limit);
%         toc
%         disp('------------------')
    end
end

%%%%2s
for i=1:length(d)
    for j=i:length(d)
%         disp('m2')
%         disp([i j k])
%         tic
        C_simplified(i,j,k) = C_simplified(i,j,k) + m2*simplify(diff(C(i,j,k),m2),limit);
%         toc
%         disp('------------------')
    end
end

for i=1:length(d)
    for j=i:length(d)
%         disp('I2')
%         disp([i j k])
%         tic
        C_simplified(i,j,k) = C_simplified(i,j,k) + I2*simplify(diff(C(i,j,k),I2),limit);
%         toc
%         disp('------------------')
    end
end

fid = fopen('C.txt', 'w');
for i=1:length(d)
    for j=i:length(d)
        fprintf(fid,'%%C_%d_%d_%d\r\n\r\n',i,j,k);
        s = char(C_simplified(i,j,k));
        fprintf(fid,'%s\r\n\r\n', s);
    end
end
fclose(fid);

fid = fopen('C12GB.txt', 'w');
for i=1:length(d)
    for j=i:length(d)
        fprintf(fid,'%%C_%d_%d_%d\r\n\r\n',i,j,k);
        s = char(C_simplified(i,j,k));
        fprintf(fid,'%s\r\n\r\n', s);
    end
end
fclose(fid);
end