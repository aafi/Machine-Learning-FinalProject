function[name] = read_word_name(filename)
% Warning: doesn't corrent work if ',' is part of one of the words
fid=fopen(filename);
name={};
this_line=fgetl(fid);
while(this_line~=-1)
    result = strsplit(this_line,',');    % Octave command to split delimited string
    word = result{1,1};
    name = [name;word];
    this_line=fgetl(fid);
end