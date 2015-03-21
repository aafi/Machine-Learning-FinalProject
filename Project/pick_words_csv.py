#!/usr/bin/env python

# called by plot_eigenword.m
# this version writes out .csv
# called as ./pick_words_csv.py eigenwords_google.txt  'apple banana carrot' 

import os, sys

def extract_eigenwords_csv(filename, category_names):
	os.system('touch colors.csv; rm colors.csv')
	input_file = open(filename)
	output_file = open('colors.csv','w')
	for line in input_file:
		list = line.strip().split(' ')
		name = list[0]
		if (name in category_names):
			eigenwords = [float(word) for word in list[1:]]
			output_file.write(name + ',')
			number_string = ','.join([str(num) for num in eigenwords])
			output_file.write(number_string)
			output_file.write('\n')
	output_file.close()
	input_file.close()

if __name__ == '__main__':
	filename = sys.argv[1]
	name_list = sys.argv[2].split()
	print 'source file    = ', filename
	print 'category names = ', ' '.join(name_list)
	filetype = filename.split('.')[1].strip()
	extract_eigenwords_csv(filename, name_list)