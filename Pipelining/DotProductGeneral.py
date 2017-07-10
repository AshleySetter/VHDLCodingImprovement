import numpy as np

N = 512
NumClkCycles=0

a = range(0, N)
b = range(0, N)

s_tmp = np.zeros_like(a)
for i in range(0, N):
    s_tmp[i] = a[i]*b[i]
NumClkCycles += 1

print(s_tmp)

N_cnt = N>>1 # bit shift right by 1 (i.e. N/2)


while N_cnt > 0:
    for i in range(0, N_cnt):
        #print("{} = {} + {}".format(s_tmp[i*2] + s_tmp[i*2+1], s_tmp[i*2], s_tmp[i*2+1]))
        #print("s_tmp[{}] = s_tmp[{}] + s_tmp[{}]".format(i, i*2, i*2+1))
        s_tmp[i] = s_tmp[i*2] + s_tmp[i*2+1]        
    N_cnt = N_cnt>>1
    NumClkCycles += 1

s = s_tmp[0]

print(np.ceil(np.log2(N)))

print("Code Ans: {} for in {} clk cycles".format(s, NumClkCycles))

print("Correct Ans: {}".format(np.sum(np.array(list(a))*np.array(list(b)))))
