function result = stem(A)

cellfun(@stem, A, 'UniformOutput', false)

end