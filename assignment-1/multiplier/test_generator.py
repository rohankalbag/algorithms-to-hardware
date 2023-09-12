import random

# for a
l = [i + random.randint(0, 9) for i in range(0, 250, 10)]
l.extend([i + random.randint(0, 9) for i in range(0, 250, 10)])
l.append(250 + random.randint(0, 5))
l.append(250 + random.randint(0, 5))
random.shuffle(l)
print(l)

# for b
l = [i + random.randint(0, 9) for i in range(0, 250, 10)]
l.extend([i + random.randint(0, 9) for i in range(0, 250, 10)])
l.append(250 + random.randint(0, 5))
l.append(250 + random.randint(0, 5))
random.shuffle(l)
print(l)