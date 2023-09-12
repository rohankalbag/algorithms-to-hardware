import random

# for a

l = [i + random.randint(0, 9) for i in range(0, 250, 10)]
l.extend([i + random.randint(0, 9) for i in range(0, 250, 10)])
l.append(250 + random.randint(0, 5))
l.append(250 + random.randint(0, 5))
random.shuffle(l)
print(l)

# for b
l = [i + random.randint(0, 9) for i in range(10, 250, 10)]
l.extend([i + random.randint(0, 9) for i in range(0, 250, 10)])
l.append(250 + random.randint(0, 5))
l.append(250 + random.randint(0, 5))
# to make sure there is no zero for b (divide by zero exception prevention)
l.append(0 + random.randint(1, 9))
l.append(0 + random.randint(1, 9))
random.shuffle(l)
print(l)