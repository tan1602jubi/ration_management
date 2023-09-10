# inputs = ["eat", "tae", "cat", "atc", "tac", "bat"]
# outputs = [["bat"], ["eat", "tae"], ["cat", "atc", "tac"]]


# GA = GAnagram()



def GAnagram(inputs):
    keys_ana = {}
    for i in inputs:
        curr_key = "".join(sorted(list(i)))
        if not curr_key in keys_ana.keys():
            keys_ana[curr_key] = []
            keys_ana[curr_key].append(i)
        else:
            keys_ana[curr_key].append(i)
    return list(keys_ana.values())

print(GAnagram(["eat", "tae", "cat", "atc", "tac", "bat"]))




