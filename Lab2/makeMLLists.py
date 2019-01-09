import random

def main(n,k,r):
    random.seed()
    a = "val testLists = ["
    
    for i in range(0,n):
        x = "val test" + str(i) + " = ["
        a += "test" + str(i)
        if i < n-1:
            a+= ", "
        else:
            a+= "];"
        
        for j in range(0,k):
            x += str(random.randrange(r))

            if j < k-1:
                x+= ", "

        x += "];"
        
        
        print(x)
    print(a)




main(500,250,50000)
