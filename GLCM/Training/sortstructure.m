function[Asorted]=sortstructure(A)
% A = struct(...
%     'values', {0.65,0.68,0.70,0.71,0.72,0.73,0.74,0.75,0.78,0.80,0.81,0.83,00.85}, ...
%     'class', {0,1,1,1,0,0,1,1,1,0,1,1,1});

for id = 1:length(A)
    fprintf('%d\n',id)
    disp(A(id))
end

Afields = fieldnames(A);
Acell = struct2cell(A);
sz = size(Acell)   ;

% Convert to a matrix
Acell = reshape(Acell, sz(1), []);      % Px(MxN)

% Make each field a column
Acell = Acell';                         % (MxN)xP

% Sort by first field "name"
Acell = sortrows(Acell, 1);

% Put back into original cell array format
Acell = reshape(Acell', sz);

% Convert to Struct
Asorted = cell2struct(Acell, Afields, 1);

for id = 1:length(Asorted)
    fprintf('%d\n',id);
    disp(Asorted(id));
end