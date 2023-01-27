function printEquations6x6(fileName)
clc

fid = fopen([fileName,'.txt'], 'w');

%% C's
for zz = 1:6

    fprintf(fid, ['C',num2str(zz),' = [']);

    for kk = 1:11
        str = char(evalin('base',['C',num2str(zz),'(',num2str(kk),')']));
        disp(['C',num2str(zz),'(',num2str(kk),')'])

        str = strrep(str, 'A1(0)', 'A1');
        str = strrep(str, 'A2(0)', 'A2');
        str = strrep(str, 'A3(0)', 'A3');
        str = strrep(str, 'A4(0)', 'A4');
        str = strrep(str, 'A5(0)', 'A5');
        str = strrep(str, 'A6(0)', 'A6');

        str = strrep(str, 'i', '1i');
        str = strrep(str, 'I', '1i');

        len = length(str);

        parts = floor(len/80);

        if parts == 0
            fprintf(fid, [str '\n\n']);
%             disp([str])
%             disp([' '])
            continue;
        end
        
        idxl = 1;
        idxr = 80;
        while idxr <= len
            if idxr == len
                fprintf(fid, [str(idxl:idxr)]);
%                 disp(str(idxl:idxr))
%                 disp([' '])
            	break;
            end
            
            L = idxl - 1 + strfind(str(idxl:idxr),'+');
            R = idxl - 1 + strfind(str(idxl:idxr),'-');
            idxr = max([L,R])-1;
            
            fprintf(fid, [str(idxl:idxr) '...\n']);
%             disp(str(idxl:idxr))
            
            idxl = idxr + 1;
            idxr = idxl + 80;
            
            if idxr > len
                idxr = len;
            end
        end
        if kk ~= 11
            fprintf(fid, ['\n\n']);
        end
    end
    fprintf(fid, ['];\n\n\n']);
end

%% D's
for kk = 1:9
    for zz = 1:6
        fprintf(fid, ['d',num2str(kk),'A',num2str(zz),' = ']);
        
        str = char(evalin('base',['WdA(',num2str(kk),',',num2str(zz),')']));
        disp([['d',num2str(kk),'A',num2str(zz)]])
        
        str = strrep(str, 'diff(A1(0), 0)', 'd1A1');
        str = strrep(str, 'diff(A2(0), 0)', 'd1A2');
        str = strrep(str, 'diff(A3(0), 0)', 'd1A3');
        str = strrep(str, 'diff(A4(0), 0)', 'd1A4');
        str = strrep(str, 'diff(A5(0), 0)', 'd1A5');
        str = strrep(str, 'diff(A6(0), 0)', 'd1A6');
        
        str = strrep(str, 'diff(A1(0), 0, 0)', 'd2A1');
        str = strrep(str, 'diff(A2(0), 0, 0)', 'd2A2');
        str = strrep(str, 'diff(A3(0), 0, 0)', 'd2A3');
        str = strrep(str, 'diff(A4(0), 0, 0)', 'd2A4');
        str = strrep(str, 'diff(A5(0), 0, 0)', 'd2A5');
        str = strrep(str, 'diff(A6(0), 0, 0)', 'd2A6');
        
        str = strrep(str, 'diff(A1(0), 0, 0, 0)', 'd3A1');
        str = strrep(str, 'diff(A2(0), 0, 0, 0)', 'd3A2');
        str = strrep(str, 'diff(A3(0), 0, 0, 0)', 'd3A3');
        str = strrep(str, 'diff(A4(0), 0, 0, 0)', 'd3A4');
        str = strrep(str, 'diff(A5(0), 0, 0, 0)', 'd3A5');
        str = strrep(str, 'diff(A6(0), 0, 0, 0)', 'd3A6');
        
        str = strrep(str, 'diff(A1(0), 0, 0, 0, 0)', 'd4A1');
        str = strrep(str, 'diff(A2(0), 0, 0, 0, 0)', 'd4A2');
        str = strrep(str, 'diff(A3(0), 0, 0, 0, 0)', 'd4A3');
        str = strrep(str, 'diff(A4(0), 0, 0, 0, 0)', 'd4A4');
        str = strrep(str, 'diff(A5(0), 0, 0, 0, 0)', 'd4A5');
        str = strrep(str, 'diff(A6(0), 0, 0, 0, 0)', 'd4A6');
        
        str = strrep(str, 'diff(A1(0), 0, 0, 0, 0, 0)', 'd5A1');
        str = strrep(str, 'diff(A2(0), 0, 0, 0, 0, 0)', 'd5A2');
        str = strrep(str, 'diff(A3(0), 0, 0, 0, 0, 0)', 'd5A3');
        str = strrep(str, 'diff(A4(0), 0, 0, 0, 0, 0)', 'd5A4');
        str = strrep(str, 'diff(A5(0), 0, 0, 0, 0, 0)', 'd5A5');
        str = strrep(str, 'diff(A6(0), 0, 0, 0, 0, 0)', 'd5A6');
        
        str = strrep(str, 'diff(A1(0), 0, 0, 0, 0, 0, 0)', 'd6A1');
        str = strrep(str, 'diff(A2(0), 0, 0, 0, 0, 0, 0)', 'd6A2');
        str = strrep(str, 'diff(A3(0), 0, 0, 0, 0, 0, 0)', 'd6A3');
        str = strrep(str, 'diff(A4(0), 0, 0, 0, 0, 0, 0)', 'd6A4');
        str = strrep(str, 'diff(A5(0), 0, 0, 0, 0, 0, 0)', 'd6A5');
        str = strrep(str, 'diff(A6(0), 0, 0, 0, 0, 0, 0)', 'd6A6');
        
        str = strrep(str, 'diff(A1(0), 0, 0, 0, 0, 0, 0, 0)', 'd7A1');
        str = strrep(str, 'diff(A2(0), 0, 0, 0, 0, 0, 0, 0)', 'd7A2');
        str = strrep(str, 'diff(A3(0), 0, 0, 0, 0, 0, 0, 0)', 'd7A3');
        str = strrep(str, 'diff(A4(0), 0, 0, 0, 0, 0, 0, 0)', 'd7A4');
        str = strrep(str, 'diff(A5(0), 0, 0, 0, 0, 0, 0, 0)', 'd7A5');
        str = strrep(str, 'diff(A6(0), 0, 0, 0, 0, 0, 0, 0)', 'd7A6');
        
        str = strrep(str, 'diff(A1(0), 0, 0, 0, 0, 0, 0, 0, 0)', 'd8A1');
        str = strrep(str, 'diff(A2(0), 0, 0, 0, 0, 0, 0, 0, 0)', 'd8A2');
        str = strrep(str, 'diff(A3(0), 0, 0, 0, 0, 0, 0, 0, 0)', 'd8A3');
        str = strrep(str, 'diff(A4(0), 0, 0, 0, 0, 0, 0, 0, 0)', 'd8A4');
        str = strrep(str, 'diff(A5(0), 0, 0, 0, 0, 0, 0, 0, 0)', 'd8A5');
        str = strrep(str, 'diff(A6(0), 0, 0, 0, 0, 0, 0, 0, 0)', 'd8A6');
        
        str = strrep(str, 'diff(A1(0), 0, 0, 0, 0, 0, 0, 0, 0)', 'd9A1');
        str = strrep(str, 'diff(A2(0), 0, 0, 0, 0, 0, 0, 0, 0)', 'd9A2');
        str = strrep(str, 'diff(A3(0), 0, 0, 0, 0, 0, 0, 0, 0)', 'd9A3');
        str = strrep(str, 'diff(A4(0), 0, 0, 0, 0, 0, 0, 0, 0)', 'd9A4');
        str = strrep(str, 'diff(A5(0), 0, 0, 0, 0, 0, 0, 0, 0)', 'd9A5');
        str = strrep(str, 'diff(A6(0), 0, 0, 0, 0, 0, 0, 0, 0)', 'd9A6');
        
        str = strrep(str, 'A1(0)', 'A1');
        str = strrep(str, 'A2(0)', 'A2');
        str = strrep(str, 'A3(0)', 'A3');
        str = strrep(str, 'A4(0)', 'A4');
        str = strrep(str, 'A5(0)', 'A5');
        str = strrep(str, 'A6(0)', 'A6');
        
        str = strrep(str, 'i', '1i');
        str = strrep(str, 'I', '1i');
        
        len = length(str);
        
        parts = floor(len/80);
        
        if parts == 0
            fprintf(fid, [str '; \n\n']);
%             disp([str])
%             disp([' '])
            continue;
        end
        
        idxl = 1;
        idxr = 80;
        while idxr <= len
            if idxr == len
                fprintf(fid, [str(idxl:idxr)]);
%                 disp(str(idxl:idxr))
%                 disp([' '])
                break;
            end
            
            L = idxl - 1 + strfind(str(idxl:idxr),'+');
            R = idxl - 1 + strfind(str(idxl:idxr),'-');
            idxr = max([L,R])-1;
            
            fprintf(fid, [str(idxl:idxr) '...\n']);
%             disp(str(idxl:idxr))
            
            idxl = idxr + 1;
            idxr = idxl + 80;
            
            if idxr > len
                idxr = len;
            end
        end
        fprintf(fid, [';\n\n\n']);
    end
end

%% B's
for zz = 1:6
    
    fprintf(fid, ['B',num2str(zz),' = [A',num2str(zz),'\n\n']);
    
    for kk = 1:9
        fprintf(fid, ['d',num2str(kk),'A',num2str(zz),'\n\n']);
    end
    fprintf(fid, ['];\n\n\n']);
end

fclose(fid); 



%         for ll = 1:parts
%             idx=[(ll-1)*80+1:(ll-1)*80+80];
%             fprintf(fid, [str(idx) '...\n']);
%         end
        
%         if kk ~= 6
%             fprintf(fid, [str(idx(end)+1:len) '\n\n']);
%         else
%             fprintf(fid, [str(idx(end)+1:len)]);
%         end
    
    