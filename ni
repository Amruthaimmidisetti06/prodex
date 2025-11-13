INF = 1000

# Function to search for the vertex with the minimum distance
def search_min(length, se, n):
    global v
    mi = INF
    v = -1
    for i in range(n):
        if se[i] == 0:
            if length[i] < mi:
                mi = length[i]
                v = i
    return v


# Initialize lists
se = [0] * 10
length = []
path = []
graph = []

# Input number of vertices
n = int(input("Enter number of vertices: "))

# Input adjacency matrix
print("Enter the adjacency matrix:")
for i in range(n):
    graph.append(list(map(int, input().split())))

# Input source vertex
s = int(input("Enter source node: "))

# --- Initialization Part ---
for i in range(n):
    if graph[s][i] == 0:
        length.append(INF)
        path.append(0)
    else:
        length.append(graph[s][i])
        path.append(s)

se[s] = 1
length[s] = 0

# --- Iteration Part ---
c = 1
while c:
    c = 0
    j = search_min(length, se, n)
    if j == -1:
        break
    se[j] = 1
    for i in range(n):
        if se[i] != 1:
            if graph[i][j] != 0:
                if length[j] + graph[i][j] < length[i]:
                    length[i] = length[j] + graph[i][j]
                    path[i] = j

    for i in range(n):
        if se[i] == 0:
            c += 1

# --- Output ---
print("\nFrom (source vertex):", s)
print("Vertex\tLength\tShortest Path")

for i in range(n):
    if i != s:
        print(f"{i}\t{length[i]}\t", end='')
        j = i
        # Print path in reverse (destination -> source)
        route = []
        while j != s:
            route.append(j)
            j = path[j]
        route.append(s)
        route.reverse()
        print(" -> ".join(map(str, route)))
