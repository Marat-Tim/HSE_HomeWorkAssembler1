import random
import os
import time


def main():
    in_path = "tests/test.in"
    out_path = "tests/test.out"

    programs_names = input("Какие программы тестируем?(Если все, то нажмите enter)\n").split()

    if len(programs_names) == 0:
        programs_names = [filename[:-4] for filename in os.listdir() if filename[-3:] == "exe"]

    programs_time = {key: [] for key in programs_names}

    for _ in range(100):
        n = random.randint(1, 10000)
        lst = [random.randint(-1000, 1000) for _ in range(n)]

        s = f"{n}\n" + " ".join(map(str, lst))
        with open(in_path, 'w') as f:
            f.write(s)

        correct_list = list(map(str, filter(lambda x: x > 0, lst)))
        correct_out = "" if len(correct_list) == 0 else (' '.join(correct_list) + " ")

        for program_name in programs_names:
            start_t = time.time()
            os.system(f"./{program_name}.exe < {in_path} > {out_path}")
            end_t = time.time()
            programs_time[program_name].append(end_t - start_t)
            with open(out_path, 'r') as f:
                out = f.read()
            if out != correct_out:
                print("Ошибка! В файле test.in указаны данные при которых произошла ошибка")
                return
    else:
        print("Ошибок не найдено")
        for program_name in programs_names:
            print(
                f"Среднее время выполнения {program_name}: {sum(programs_time[program_name]) / len(programs_time[program_name])}")


main()
