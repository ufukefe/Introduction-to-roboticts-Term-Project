clc;
g_simplified = sym(zeros(size(g)));
g = g*5/49;
limit=50;
%%%%1s
for i=1:length(d)
%         disp('m1')
%         disp(i)
%         tic
        g_simplified(i,1) = m1*simplify(diff(g(i,1),m1),limit);
%         toc
%         disp('------------------')
end
for i=1:length(d)
%         disp('I1')
%         disp(i)
%         tic
        g_simplified(i,1) =g_simplified(i,1)+ I1*simplify(diff(g(i,1),I1),limit);
%         toc
%         disp('------------------')
end

%%%%2s
for i=1:length(d)
%         disp('m2')
%         disp(i)
%         tic
        g_simplified(i,1) = g_simplified(i,1)+ m2*simplify(diff(g(i,1),m2),limit);
%         toc
%         disp('------------------')
end
for i=1:length(d)
%         disp('I2')
%         disp(i)
%         tic
        g_simplified(i,1) =g_simplified(i,1)+ I2*simplify(diff(g(i,1),I2),limit);
%         toc
%         disp('------------------')
end

fid = fopen('gmatrix12GB.txt', 'w');
for i=1:length(d)
        fprintf(fid,'%%g%d\r\n\r\n',i);
        s = char(g_simplified(i,1));
        fprintf(fid,'%s\r\n\r\n', s);
end
fclose(fid);

g = g*49/5;