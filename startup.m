% Get current path (pwd = present working directory)
paths = fullfile(pwd, {'airfoils'});

% add paths to MATLAB search path
for i = 1:length(paths)
    addpath(paths{i});
end
