clc

fid = fopen('semiAnalyticalSolutions5modes_1.txt', 'w');

%% C's
for zz = 1:5

    fprintf(fid, ['C',num2str(zz),' = [']);

    for kk = 1:9
        disp(['C - ',num2str(zz),' # ',num2str(kk)])
        str = char(evalin('base',['C',num2str(zz),'(',num2str(kk),')']));

        str = strrep(str, 'A1(0)', 'A1');
        str = strrep(str, 'A2(0)', 'A2');
        str = strrep(str, 'A3(0)', 'A3');
        str = strrep(str, 'A4(0)', 'A4');
        str = strrep(str, 'A5(0)', 'A5');

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
        if kk ~= 9
            fprintf(fid, ['\n\n']);
        end
    end
    fprintf(fid, ['];\n\n\n']);
end


%% B's
for zz = 1:5

    fprintf(fid, ['B',num2str(zz),' = [']);

    for kk = 1:8
        disp(['B - ',num2str(zz),' # ',num2str(kk)])
        str = char(evalin('base',['BB',num2str(zz),'(',num2str(kk),')']));

        str = strrep(str, 'A1(0)', 'A1');
        str = strrep(str, 'A2(0)', 'A2');
        str = strrep(str, 'A3(0)', 'A3');
        str = strrep(str, 'A4(0)', 'A4');
        str = strrep(str, 'A5(0)', 'A5');

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
        if kk ~= 8
            fprintf(fid, ['\n\n']);
        end
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
    
    