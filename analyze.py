with open("data/MOCK_DATA.csv") as f:
    cols = f.readline().strip().split(',')

groups = {}
for col in cols:
    prefix = col.split('_')[0]
    groups.setdefault(prefix, []).append(col)

for prefix, cols in sorted(groups.items()):
    print(f"\n{prefix.upper()}:")
    for col in cols:
        print(f"  - {col}")
