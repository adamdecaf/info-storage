#!/usr/bin/env python3
#Mike Miller, James Vannordstrand, Syth Ryan, Nigel Ploof, Kyle Hall, Shaun Meyer, Adam Shannon
import struct
def main():
	compression()

def compression():
	file = open ('wwfl.txt','r')
	data = file.read()
	file.close()
	file = open ('Compression2','w')
	wordList = data.split()
	for index in range (0,len(wordList)):
		for char in wordList[index]:
			count = 0
			for wordIndex in range(index+1,len(wordList)):
				if wordList[wordIndex].startswith(char):
					count += 1
					wordList[wordIndex] = wordList[wordIndex][1:len(wordList[wordIndex])]
				else:
					break
			if count == 0:
				file.write(char)
			else:
				file.write(char + str(count))
		file.write(' ')

main()

# 				file.write(char, "ascii"))
		# 		file.write(char.encode('ascii'))
		# 	else:
		# 		file.write(char.encode('ascii'))
		# 		file.write(bytes([count])
		# file.write(space.encode('ascii'))
