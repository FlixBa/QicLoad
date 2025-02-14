function [data, fileIndex] = QicLoad(HeaderLines, extension) % specifiy header lines, extension must be of the form '*.extension'

    % get all files
    files = dir(extension) ;

      % Check if there are CSV files in the directory
    if isempty(files)
        error('No CSV files found in the current directory.') ;
    end
    
    % Read the first file to determine matrix size
    sample_data = readmatrix(files(1).name, 'NumHeaderLines', HeaderLines) ;
    [rows, cols] = size(sample_data) ;
    
    % Initialize 3D matrix with NaNs (or zeros if preferred)
    num_files = length(files) ;
    data = NaN(rows, cols, num_files) ;
    
    % Create fileIndex cell
    fileIndex = cell(num_files, 2) ;

    % Load each CSV file into the 3D matrix
    for k = 1:num_files
        data(:,:,k) = readmatrix(files(k).name, 'NumHeaderLines', HeaderLines) ;
        fileIndex{k, 1} = k ; % store z-index
        fileIndex{k, 2} = files(k).name ; % store filename
    end

end

% This function loads QicPic csv export files into a 3D Matrix where z
% represents the individual files