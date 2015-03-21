function[name] = plot_eigenwords(filename)
% calls pick_words_csv.py and read_word_name.m
% filename contains eigenwords, which are space delimited, no header

if nargin < 1
      filename='eigenwords_google.txt';
end

% specify the testwords and the source file

test_words = 'one two three four five six seven eight nine ten 1 2 3 4 5 6 7 8 9 10 1995 1996 1997 1998 1999 2000 2001 2002 2003 2004 2005 2006 2007 2008 2009';
%test_words = 'monday tuesday wednesday sunday friday eat drink sleep his her my your';
%test_words = 'house home dog truck boat word river cat car sleep eat push drink listen carry talk disagree agree';
%test_words = 'i you he she they we us them him her our his hers';
%test_words = 'man woman boy girl lawyer doctor guy farmer teacher citizen mother wife father son husband brother daughter sister boss uncle pressure temperature permeability density stress viscosity gravity tension miles pounds degrees inches barrels tons acres meters bytes';
%test_words = 'mary patricia tricia linda barbara elizabeth liz betsy jennifer maria susan margaret dorothy lisa nancy karen betty helen john robert bob michael mike william david richard charles joseph joe thomas tom christopher daniel dan paul donald george';

system(horzcat('./pick_words_csv.py ', filename, ' "', test_words, '"'));
colors = csvread('colors.csv', 0, 0);
names = read_word_name('colors.csv');   % Warning: will not work if
colors(:,1) = [];
%% center data
mean_mat = repmat(mean(colors),size(colors,1),1);
colors = colors-mean_mat;
%% perform SVD
[u,d,v] = svd(colors);
%% plot
base = v(:,1:2);
x='PC1';
y='PC2';
d = colors*base; 
scatter(d(:,1),d(:,2),'r');
for i=1:length(names)
   text(d(i,1),d(i,2),names(i,:),'FontSize', 15);
end
xlabel(x);
ylabel(y);
print -dpdf matlabPlot.pdf;
hold off
end
