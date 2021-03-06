#!/usr/bin/python
#Author: Martin Wearn, mw20g10
#Assembler program, takes assembly input file and outputs hex line with one line per instruction

import os
import re
import sys
import binascii
import string
from optparse import OptionParser
import struct
LINES = []
SEGMLINES = []
LINKTABLE = []
MC = []
workingline = 0

def ConvertToBin(x, length):
	if type(x) == str:
		val = int(x)
	else:
		val = x
	mask = 1 << length - 1
	binary = ""
	while mask > 0:
		if mask & val:
			binary+="1"
		else:
			binary+="0"
		mask >>= 1
	return binary

#Conversion functions
def OpType(value):	#Determine instruction format type
	if value in ("ENAI", "DISI", "RETI","STF","LDF"):
		return "F"
	elif value in ("PUSH", "POP"):
		return "E"
	elif value in ("JMP"):
		return "D1"
	elif value in ("BR", "BNE", "BE", "BLT", "BGE", "BWL", "RET", "numBR"):
		return "D2"
	elif value in ("LDW", "STW"):
		return "C"
	elif value in ("ADDIB", "SUBIB", "LUI", "LLI"):
		return "B"
	elif value in ("ADD", "ADC", "NEG", "SUB", "SUC", "CMP", "AND", "OR", "XOR", "NOT", "NAND", "NOR", "NOP"):
		return "A1"
	elif value in ("ADDI", "ADCI", "SUBI", "SUCI", "CMPI", "LSL", "LSR", "ASR"):
		return "A2"
	else:
		print 'ERROR1: Unrecognised Mneumonic' + ' lineNo: ' + workingline
		sys.exit()

def regcode(value):	#Get binary equivalent of register name
	if value.upper() == "R0":
		return "000"
	elif value.upper() == "R1":
		return "001"
	elif value.upper() == "R2":
		return "010"
	elif value.upper() == "R3":
		return "011"
	elif value.upper() == "R4":
		return "100"
	elif value.upper() == "R5":
		return "101"
	elif value.upper() == "R6":
		return "110"
	elif value.upper() == "R7":
		return "111"
	elif value.upper() == "SP":
		return "111"
	elif value.upper() == "LR":
		return "000"
	else:
		print 'ERROR2: Unrecognized Register Code, is there a .define missing?' + ' lineNo: ' + workingline
		sys.exit()

def conditioncode(value):	#Get binary code for branching conditions
	if value == "BR":
		return "000"
	if value == "BNE":
		return "110"
	if value == "BE":
		return "111"
	if value == "BLT":
		return "100"
	if value == "BGE":
		return "101"
	if value == "BWL":
		return "011"
	if value == "RET":
		return "010"
	if value == "JMP":
		return "001"
	else:
		print 'ERROR3: Unrecognized Branch Condition' + ' lineNo: ' + workingline
		sys.exit()

#Args: Destination, Source, Binary
def branch(value, lineNo, b=1):	#Calculate relative branch address for PC
	#try:
	#	if b:
	#		return ConvertToBin(int(value), 8)
	#	else:
	#		return int(value)
	#except:
		for link in LINKTABLE:
			if value in ('.ISR','.isr'):			#Needs more extensive tests to ensure not branching into an ISR
				print 'ERROR12: Illegal branch to ISR' + ' lineNo: ' + workingline
				sys.exit()
			elif link[0] == value:
				if b:
					return ConvertToBin(link[1] - lineNo, 8)
				else:
					return link[1] - lineNo
		print 'ERROR4: Unknown Link Label' + ' lineNo: ' + workingline
		sys.exit()

def OpNum(value):	#Determine specific binary value for instruction
	if value == "F":
		return "11001"
	if value == "C":
		return "00000"
	elif value == "D1":
		return "11110"
	elif value == "D2":
		return "11110"
	elif value == "E":
		return "00001"
	elif value == "ADD":
		return "00010"
	elif value == "ADDI":
		return "00110"
	elif value == "ADDIB":
		return "00011"
	elif value == "ADC":
		return "00100"
	elif value == "ADCI":
		return "00101"
	elif value == "NEG":
		return "11010"
	elif value == "SUB":
		return "01010"
	elif value == "SUBI":
		return "01110"
	elif value == "SUBIB":
		return "01011"
	elif value == "SUC":
		return "01100"
	elif value == "SUCI":
		return "01101"
	elif value == "CMP":
		return "00111"
	elif value == "CMPI":
		return "01111"
	elif value == "AND":
		return "10000"
	elif value == "OR":
		return "10001"
	elif value == "XOR":
		return "10011"
	elif value == "NOT":
		return "10010"
	elif value == "NAND":
		return "10110"
	elif value == "NOR":
		return "10111"
	elif value == "LSL":
		return "11111"
	elif value == "LSR":
		return "11101"
	elif value == "ASR":
		return "11100"
	elif value == "LUI":
		return "10100"
	elif value == "LLI":
		return "10101"
	else:
		print 'ERROR5: Unrecognised Mneumonic' + ' lineNo: ' + workingline
		sys.exit()
class MyParser(OptionParser):
        def format_description(self, formatter):
            return self.description
if "__main__" == __name__:
	'''The main of the script'''
	#Optparser is a much better way of doing this. Same result but more easily expandable when adding options
	des = "---Team R4 Assembler Help---\n\r------Version: 1 (CMPI addition onwards)\
\n               2 (Changed to final ISA, added special case I's and error checking\
\n               3 (Ajr changes - Hex output added, bug fix)\
\n               4 (Added SP symbol)\
\n               5 (NOP support added, help added)\
\n               6 (Interrupt support added [ENAI, DISI, RETI])\
\n               7 (Checks for duplicate Labels)\
\n               8 (Support for any ISR location & automated startup code entry)\
\n               9 (Support for .define)\
\n              10 (Changed usage)\
\n		11 (ISR setup shortened, Numeric branching support removed)\
\n		12 (Branches automatically extended if out of 8-bit range)\
\n		13 (Comments in hexfile)\
\n      Current is most recent iteration\
\nInput Syntax: ./assemble filename\
\nCommenting uses : or ;\
\nLabels start with '.': SPECIAL .ISR/.isr-> Interrupt Service Routine)\
\n                       SPECIAL .define -> define new name for General Purpose Register, .define NAME R0-R7/SP\
\nInstruction Syntax: .[LABELNAME] MNEUMONIC, OPERANDS, ..., :[COMMENTS]\
\nRegisters: R0, R1, R2, R3, R4, R5, R6, R7==SP\
\nBranching: Only Symbolic Supported\n\
\nNotes:\
\n       Input files are assumed to end with a .asm extension\
\n       Immediate value sizes are checked\
\n       Instruction-less lines allowed\
\n       .ISR may be located anywhere in file\
\n       .define may be located anywhere, definition valid from location in file onwards, may replace existing definitions\
\n	 Error message line numbers are prefixed with f for assembly file and p for preprocessed code \n\n"

	parser = MyParser(usage="%prog [-o outfile] input", description=des, version="%prog V12")
        parser.add_option("-o", "--output", dest="outfile", metavar="FILE",
                  help="output file for the assembled output")
	#parser.add_option("-l", "--log", dest="logfile", metavar="FILE", help="
	#@todo add a verbose and quiet mode?
        (options, args) = parser.parse_args()

	assemfile = args[0]		#filename only
	#Determine input/output file paths
	print '--------Converting File %s.asm--------\n' % assemfile
	if assemfile.endswith(".asm"):
		INPUTFILE = assemfile
		OUTPUTFILE = assemfile[:-len(".asm")] + ".mc"
		HEXFILE = assemfile[:-len(".asm")] + ".hex"
	else:
		INPUTFILE = assemfile + ".asm"
		OUTPUTFILE = assemfile + ".mc"
		HEXFILE = assemfile + ".hex"
	if options.outfile: #user override
		HEXFILE = options.outfile
	if not os.path.isfile(INPUTFILE):
		parser.print_help()

	ifile = open(INPUTFILE, 'r')
	outfile = open(OUTPUTFILE, 'w')
	hexfile = open(HEXFILE,'w')

	LINES = ifile.readlines()	#Read input file contents

	#Seperate each line into a list of elements
	print '--------Interpreting Syntax-----------'
	for l, line in enumerate(LINES):
		workingline = 'f' + str(l+1) + ' -> '
		for p in line:
			workingline += p + ' '
		#print '1. ' + line.strip('\n').strip('\t')
		try:
			code = line.split(':')[0]			#remove comments and newline char
			code = code.split(';')[0]
		except:
			code = line	#no comments on line
		if code.strip('\t').strip('\n') == '':			#skip blank lines
			continue
		#print code
		#print '2. ' + code.strip('\t')
		code = code.replace('\n',',')
		code = code.replace('\t',',')				#Remove tabs
		code = code.replace(' ',',')
		pass_zero = code.split(',')				#seperate by comma
		pass_one = []
		for seg in pass_zero:
			if(seg != ''):
				pass_one.append(seg)
		#print pass_one
		pass_two = []
		for j, part in enumerate(pass_one):
			pass_one[j] = pass_one[j].strip()		#remove lead/trail spaces
			pass_one[j] = pass_one[j].strip('[').strip(']').strip('#')
			if pass_one[j].count(' ') >= 1:			#check if there are spaces in string
				pass_two.extend(pass_one[j].split(' '))	#seperate by spaces
			else:
				pass_two.append(pass_one[j])
		#print pass_two
		SEGMLINES.append(pass_two)				#create list of lists
		#print pass_two

	#Check for invalid mneumonic
	for l, line in enumerate(SEGMLINES):
		workingline = 'f' + str(l+1) + ' -> '
		for p in line:
			workingline += p + ' '
		if not line[0].startswith('.'):
			OpType(line[0])

	defines = [''] * 10
	definelines = []
	#Check for any .defines in file
	for l, line in enumerate(SEGMLINES):
		workingline = 'f' + str(l+1) + ' -> '
		for p in line:
			workingline += p + ' '
		if(line[0] == '.define'):				#Create variable mapping for new define statement
			print 'Found definition', line
			if (line[2] == 'R0'):
				defines[0] = line[1]
			elif (line[2] == 'R1'):
				defines[1] = line[1]
			elif (line[2] == 'R2'):
				defines[2] = line[1]
			elif (line[2] == 'R3'):
				defines[3] = line[1]
			elif (line[2] == 'R4'):
				defines[4] = line[1]
			elif (line[2] == 'R5'):
				defines[5] = line[1]
			elif (line[2] == 'R6'):
				defines[6] = line[1]
			elif (line[2] in ('R7','SP')):
				defines[7] = line[1]
			else:
				print 'ERROR13: Required .define format - .define NAME R0-R7/SP' + ' lineNo: ' + workingline
				sys.exit()
			definelines.append(line)			#remove define from file
		else:							#Check if line has any current defines
			#print 'Not .define line - ', line,
			for j, part in enumerate(line):
				if part in defines:
					#print 'Identified', part,
					line[j] = 'R' + str(defines.index(part))
			#print ''
	#Remove .defines
	for d in definelines:
		SEGMLINES.remove(d)
	print 'Done'

	#Check each line for a link reference and create link table
	print '--------Locating ISR----------'
	ISRLines = 0
	ISR = 0
	ISRcalc = 0
	ISRlen = 0
	#Find ISR, and remove label
	for i, line in enumerate(SEGMLINES):
		if (line[0] in ('.ISR','.isr')):				#ISR located
			if ISR == 1:
				print 'ERROR12: Multiple ISRs Present'
				sys.exit()
			ISR = 1
			ISRloc = i
			ISRcalc = 1
			SEGMLINES[i].remove(line[0])			#remove label from instruction
		elif ('RETI' in line):
			if (ISRcalc == 1):				#Set length of ISR
				ISRlen = ISRLines+2
				ISRcalc = 0
				print 'info: ISR Recognized - line ', ISRloc, ', length ', ISRlen
		else:
			if (ISRcalc == 1):				#Count length of ISR
				ISRLines = ISRLines + 1
	#Extract ISR
	ISR = []
	for i in range(ISRlen):
		ISR.append(SEGMLINES.pop(ISRloc))
	for i in range(ISRlen):
		print "      asm file line", ISRloc + i, ISR[i]
	if ISRlen < 1:
		print "No ISR Found"
		ISR.insert(0, ['RETI'])
		ISRlen = 1
		ISR.insert(0, ['numBR', '2'])
		SEGMLINES[15:1] = ISR #Insert ISR into location 16 in memory (15 accounts for branch over)
	else:
		#Add code for setting up and performing jump over isr for normal program flow
		tempsplit = (ISRlen+16)//256
		ISR.insert(0, ['ADDIB', 'R0', '0'])#Intentionally left blank for temporary conext saving
		ISR.insert(0, ['JMP', 'R0', '0'])#instruction location 16
		ISR.insert(0, ['LLI', 'R0', str(ISRlen+16 - tempsplit*256)])
		if tempsplit > 0:
			ISR.insert(0, ['LUI', 'R0', str(tempsplit)])
		full = [None] * 8
		for i, l in enumerate(SEGMLINES):#Find unused register
			if i < 11:
				for p in l:
					if p in ['R7','SP']:
						full[7] = 1;
					elif p == 'R6':
						full[6] = 1
					elif p == 'R5':
						full[5] = 1
					elif p == 'R4':
						full[4] = 1
					elif p == 'R3':
						full[3] = 1
					elif p == 'R2':
						full[2] = 1
					elif p == 'R1':
						full[1] = 1
					elif p == 'R0':
						full[0] = 1
		empty = -1
		for i, r in enumerate(full):
			if r == None:
				empty = i
				break
		if empty == -1:
			print "ERROR14:Unused register not found"
			sys.exit()
		ISR.insert(0, ['STW', 'R0', 'R' + str(empty), '15'])
		ISR.append(['LDW', 'R0', 'R' + str(empty), '15'])
		if tempsplit > 0:
			SEGMLINES[11:1] = ISR #Insert ISR into location 16 in memory (11 accounts for jump over)
		else:
			SEGMLINES[12:1] = ISR #Insert ISR into location 16 in memory (12 accounts for jump over)
	#print ISR
	#Create link table, ignoring ISR
	print '--------Creating Link Table----------'
	for i, line in enumerate(SEGMLINES):
		if line[0].startswith('.'):
			if (line[0] in (l[0] for l in LINKTABLE)):	#Check if label already exists in linktable
				print 'ERROR10: Duplicate Symbolic Links (', line[0], ')' + ' lineNo: ' + workingline
				sys.exit()
			LINKTABLE.append([line[0], i])			#add link consisting of LABEL and line no.
			SEGMLINES[i].remove(line[0])			#remove label from instruction
	#Check for out-of-range branching
	finish = 0
	autoCount = 0
	while finish == 0:						#Repeat checking until there are no branches out-of-bounds (middle branch max 125 as 2 lines used to extend)
		newSEGMLINES = []
		newSEGMLINES.extend(SEGMLINES)
		for i, line in enumerate(SEGMLINES):
			if (OpType(line[0]) == 'D2') & (line[0] != 'numBR') & (line[0] != 'RET'):
				distance = branch(line[1], i, 0)
				if distance > 127:			#Branching forwards more than possible
					autoCount += 1
					newSEGMLINES.insert(i, ['BR', '+auto' + str(autoCount)])#new branch source
					newSEGMLINES.insert(i+125, ['numBR', '2'])		#main program branches over new instruction
					newSEGMLINES.insert(i+125, newSEGMLINES.pop(i+1))	#new branch destination, and old branch source
					for l in LINKTABLE:					#update new link positions
						if l[1] >= (i+124):
							l[1] += 2
					LINKTABLE.append(['+auto' + str(autoCount), i+125])	#add new link to table
					finish = 1						#Leave current pass of loop
					SEGMLINES = newSEGMLINES[:]
					break
				elif distance < -128:			#Branching backwards more than possible
					autoCount += 1
					newSEGMLINES.insert(i-126, ['numBR', '2'])		#main program branches over new instruction
					newSEGMLINES.insert(i-125, newSEGMLINES.pop(i+1))	#new branch destination, and old branch source
					newSEGMLINES.insert(i+2, ['BR', '+auto' + str(autoCount)])#new branch source
					for l in LINKTABLE:					#update new link positions
						if l[1] >= (i-126):
							l[1] += 2
					LINKTABLE.append(['+auto' + str(autoCount), i-125])	#add new link to table
					finish = 1						#Leave current pass of loop
					SEGMLINES = newSEGMLINES[:]
					break
		if finish == 1:
			finish = 0
		else:
			finish = 2
	SEGMLINES = newSEGMLINES[:]
	#Check if ISR jump needs recalculating
	if ISRlen  > 1:
		if newSEGMLINES.index(['RETI']) != ISRlen+15:
			tempsplit = (newSEGMLINES.index(['RETI'])+1)//256
			newSEGMLINES[12][2] = str(tempsplit)
			newSEGMLINES[13][2] = str(newSEGMLINES.index(['RETI'])+1 - tempsplit*256)
	
	print 'Program File After Preprocessing'
	for i, s in enumerate(SEGMLINES):
		if (OpType(s[0]) == 'D2') & (s[0] != 'numBR') & (s[0] != 'RET'):
			print i, '    ', s, '---->', branch(s[1], i, 0)
		else:
			print i, '    ', s
	

	print 'Link Table'
	for l in LINKTABLE:
		print '    ', l

	#Check for over-sized immediate values
	for i, line in enumerate(SEGMLINES):
		workingline = 'p' + str(i+1) + ' -> '
		for p in line:
			workingline += p + ' '
		if line[0] in ('LSL', 'LSR', 'ASR'):
			if int(line[3]) > 16:
				print 'ERROR6: Shifting By More Than 16' + ' lineNo: ' + workingline
				sys.exit()
			elif int(line[3]) < 0:
				print 'ERROR6: Negative Shifting' + ' lineNo: ' + workingline
				sys.exit()
		elif line[0] in ('ADDI', 'ADCI', 'SUBI', 'SUCI', 'LDW', 'STW'):
			if int(line[3]) > 15 or int(line[3]) < -16 :
				print 'ERROR7: Imm5 Out Of Bounds' + ' lineNo: ' + workingline
				sys.exit()
		elif line[0] in ('CMPI', 'JMP'):
			if int(line[2]) > 15 or int(line[2]) < -16:
				print 'ERROR7: Imm5 Out Of Bounds' + ' lineNo: ' + workingline
				sys.exit()
		elif line[0] in ('ADDIB', 'SUBIB'):
			if int(line[2]) > 127 or int(line[2]) < -128:
				print 'ERROR8: Arith Imm8 Out Of Bounds' + ' lineNo: ' + workingline
				sys.exit()
		elif line[0] in ('LUI', 'LLI'):
			if int(line[2]) > 255:
				print 'ERROR8: Load Imm8 Out Of Bounds' + ' lineNo: ' + workingline
				sys.exit()

	#Convert each element to machine code and concatenate
	print '--------Converting to machine code-----------'
	#print 'Converting::',
	for i, line in enumerate(SEGMLINES):
		workingline = 'p' + str(i+1) + ' -> '
		for p in line:
			workingline += p + ' '
		try:
			if OpType(line[0]) == 'F':				#Interrupt operations
				if line[0] == 'ENAI':
					MC.append(OpNum('F') + '001' + '00000000')
				elif line[0] == 'DISI':
					MC.append(OpNum('F') + '010' + '00000000')
				elif line[0] == 'RETI':
					MC.append(OpNum('F') + '000' + '11100000')#Always reads location pointed to by SP
				elif line[0] == 'STF':
					MC.append(OpNum('F') + '011' + '00000000')
				elif line[0] == 'LDF':
					MC.append(OpNum('F') + '100' + '00000000')
			elif OpType(line[0]) == 'E':				#Stack operations
				temp = '0'
				if line[0] == 'PUSH':
					temp += '1'
				else:
					temp += '0'
				temp += '001'
				if line[1] == 'LR':
					temp += '1'
				else:
					temp += '0'
				temp += '00' + regcode(line[1]) + '00001'
				MC.append(temp)
			elif OpType(line[0]) == 'D1':				#Control transfer: Jump
				MC.append(OpNum('D1') + conditioncode(line[0]) + regcode(line[1]) + ConvertToBin(line[2], 5))
			elif OpType(line[0]) == 'D2':				#Control transfer: Others
				if line[0] == 'RET':				#Specific -> Return
					MC.append(OpNum('D2') + conditioncode(line[0]) + '00000000')
				elif line[0] == 'numBR':			#Special PseudoInstruction for branching over ISR
					MC.append(OpNum('D2') + conditioncode('BR') + ConvertToBin(int(line[1]),8))
				else:
					MC.append(OpNum('D2') + conditioncode(line[0]) + branch(line[1], i))
					tempi = branch(line[1], i, 0)
					if  tempi > 127 or tempi < -128:
						print 'ERROR9: Imm8 Branch Out Of Bounds' + ' lineNo: ' + workingline
						sys.exit()
			elif OpType(line[0]) == 'C':				#Data transfer
				temp = '0'
				if line[0] == 'STW':
					temp += '1'
				else:
					temp += '0'
				temp += '000'
				temp += regcode(line[1]) + regcode(line[2]) + ConvertToBin(line[3], 5)
				MC.append(temp)
			elif OpType(line[0]) == 'B':				#Byte immediate
				temp = OpNum(line[0])
				temp += regcode(line[1])
				temp += ConvertToBin(line[2], 8)
				MC.append(temp)
			elif OpType(line[0]) == 'A1':				#Data manipulation:Register
				if (line[0] == 'NEG'):	#NEG
					MC.append(OpNum(line[0]) + regcode(line[1]) + regcode(line[2]) + '000' + '00')
				elif (line[0] == 'CMP'):#CMP
					MC.append(OpNum(line[0]) + '000' + regcode(line[1]) + regcode(line[2]) + '00')
				elif (line[0] == 'NOT'):#NOT
					MC.append(OpNum(line[0]) + regcode(line[1]) + regcode(line[2]) + '000' + '00')
				elif (line[0] == 'NOP'):
					MC.append(OpNum(line[0]) + '00000000000')
				else:
					MC.append(OpNum(line[0]) + regcode(line[1]) + regcode(line[2]) + regcode(line[3]) + '00')
			elif OpType(line[0]) == 'A2':				#Data manipulation:Immediate
				if (line[0] == 'CMPI'):	#CMPI
					MC.append(OpNum(line[0]) + '000' + regcode(line[1]) + ConvertToBin(line[2], 5))
				else:
					MC.append(OpNum(line[0]) + regcode(line[1]) + regcode(line[2]) + ConvertToBin(line[3], 5))
		except IndexError:
			print 'ERROR15: Insufficient instruction operands' + ' lineNo: ' + workingline
			sys.exit()

	# AJR - Do we need binary?
	##Output result to file
	#print 'Writing machine code to file %s.mc...\n' % assemfile
	#for line in MC:
	#	outfile.write(line + '\n')
	#

	#Output to hex file too
	print 'Hex Output:',
	for i, line in enumerate(MC):
		hexline = ''.join([ "%x"%string.atoi(bin,2) for bin in line.split() ])
		while(len(hexline) < 4):
			hexline = '0'+ hexline
		print(hexline),
		hexline += " //"
		for p in SEGMLINES[i]:
			hexline += p + ' ' 
		hexfile.write(hexline + '\n')
	print("\n"),

	print '--------Assembly Complete!--------\n'
