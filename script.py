import random
import os
import time

in_path = "tests/test.in"
out_path1 = "tests/test.out1"
out_path2 = "tests/test.out2"

code_c_time = []
code_nice_s_time = []

for _ in range(100):
    n = random.randint(1, 10000)
    lst = [random.randint(-1000, 1000) for _ in range(n)]
    s = f"{n}\n" + " ".join(map(str, lst))
    with open(in_path, 'w') as f:
        f.write(s)
        
    start_t = time.time()
    os.system(f"./code_c.exe < {in_path} > {out_path1}")
    end_t = time.time()
    code_c_time.append(end_t - start_t)
    
    start_t = time.time()
    os.system(f"./code_nice_s.exe < {in_path} > {out_path2}")
    end_t = time.time()
    code_nice_s_time.append(end_t - start_t)
    
    with open(out_path1, 'r') as f:
    	out1 = f.read()
    with open(out_path2, 'r') as f:
    	out2 = f.read()
    correct_list = list(map(str, filter(lambda x: x > 0, lst)))
    correct_out = "" if len(correct_list) == 0 else (' '.join(correct_list) + " ")
    if not(out1 == out2 == correct_out):
    	print("Ошибка! В файле test.in указаны данные при которых произошла ошибка")
    	break
else:
	print("Ошибок не найдено")
	print(f"Среднее время выполнения для кода на C = {sum(code_c_time) / len(code_c_time)}")
	print(f"Среднее время выполнения для кода на ASM = {sum(code_nice_s_time) / len(code_nice_s_time)}")
    
