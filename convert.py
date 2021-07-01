print("hello . Welcome to ape seeni boola hotale")
inputFileName =input("Enter mif file name :")
outputFileName =input("Enter dat file name :")

datContent = [i.strip().split(";") for i in open(inputFileName).readlines()]

memSize =4096
memory= [0]*memSize

beginFound =False

for f in datContent:
    if f[0].strip() =="END":break

    if beginFound:
        if(len(f[0]) < 3):continue
        if (("--" in f[0]) | ("%" in f[0])) :continue
        index,value= [int(i.strip()) for i in f[0].strip().split(":")]
        memory[index] =value

    if f[0].strip() =="BEGIN":beginFound =True


for ind in range(memSize):
    if memory[ind] !=0:print(str(ind)+ " "+ str(memory[ind]))


memoryHex = [str(hex(i))[2:] for i in memory]
with open(outputFileName, 'w') as out_file:
    out_file.write('\n'.join(memoryHex))