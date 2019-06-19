import random
import csv
import time
#import json

def makePick(rankings): #function selects a player and then removes them from all rankings
    #select random list and best avail player from list
    rankSelect = random.sample(rankings,1)
    pick = rankSelect[0][0]
    
    #remove selected player from all lists
    for rnk in rankings:
        p=None #nullify
        for player in rnk:
            p=None #nullify
            if(player==pick):
                p=rnk.index(player) #find drafted player in each ranking
                break #if players' found, stop iterating through list
        if(p!=None):
            rnk.pop(p) #remove drafted player from ranking as long as player was in rankings
    return (pick,rankings) #return the pick and the updated rankings


def rundraft(): #runs through a round of the draft with given rankings
    #initialize draft rankings
    rankings=[]
    
    #iterate through text files and add each ranking to ranking list
    #yes i know this is dumb because your reading from each txt file a million times but i tried to fix it and everything broke
    for k in range(1,16): #removed 2 rankings for IP
        k=str(k)
        draft_ranking='rnk'+k+'.txt'
        with open(draft_ranking, 'r') as f:
            rnk_list = [line.strip() for line in f]
        rankings.append(rnk_list)
    #print(rankings)
    
    draftees =[] #empty list of players drafted
    pick = None #nullify variable
    
    #make n picks
    i=0
    while(i<31):
        draftees.append(makePick(rankings)[0])
        i+=1
    return draftees


def main():
    #create dictionary of all possible players
    #each dictionary item is PlayerName, Empty List of all 31 possible draft spots
    players = {
        "Jack Hughes":[0]*32,
        "Kaapo Kakko":[0]*32,
        "Bowen Byram":[0]*32,
        "Alex Turcotte":[0]*32,
        "Trevor Zegras":[0]*32,
        "Dylan Cozens":[0]*32,
        "Kirby Dach":[0]*32,
        "Vasili Podkolzin":[0]*32,
        "Peyton Krebs":[0]*32,
        "Cole Caufield":[0]*32,
        "Matthew Boldy":[0]*32,
        "Alex Newhook":[0]*32,
        "Philip Broberg":[0]*32,
        "Cam York":[0]*32,
        "Victor Soderstrom":[0]*32,
        "Moritz Seider":[0]*32,
        "Arthur Kaliyev":[0]*32,
        "Bobby Brink":[0]*32,
        "Spencer Knight":[0]*32,
        "Ville Heinola":[0]*32,
        "Thomas Harley":[0]*32,
        "Pavel Dorofeyev":[0]*32,
        "Raphael Lavoie":[0]*32,
        "Ryan Suzuki":[0]*32,
        "Philip Tomasino":[0]*32,
        "Simon Holmstrom":[0]*32,
        "Nils Hoglander":[0]*32,
        "Ryan Johnson":[0]*32,
        "Yegor Afanasyev":[0]*32,
        "Robert Mastrosimone":[0]*32,
        "Jakob Pelletier":[0]*32,
        "Patrik Puistola":[0]*32,
        "Tobias Bjornfot":[0]*32,
        "Samuel Poulin":[0]*32,
        "Connor McMichael":[0]*32,
        "Kaedan Korczak":[0]*32,
        "Ilya Nikolayev":[0]*32,
        "Albert Johansson":[0]*32,
        "Anttoni Honka":[0]*32,
        "Maxim Cajkovic":[0]*32,
        "Nick Abruzzese":[0]*32,
        "Matthew Robertson":[0]*32,
        "Alex Vlasic":[0]*32,
        "Mikko Kokkonen":[0]*32,
        "Vladislav Kolyachonok":[0]*32,
        "Michal Teply":[0]*32,
        "Nicholas Robertson":[0]*32,
        "Brett Leason":[0]*32,
        "Nathan Legare":[0]*32,
        "Ronnie Attard":[0]*32,
        "Albin Grewe":[0]*32,
        "Lassi Thomson":[0]*32,
        "Drew Helleson":[0]*32,
        "Marshall Warren":[0]*32,
        "Yegor Spiridonov":[0]*32,
        "John Beecher":[0]*32,
        "Jamieson Rees":[0]*32,
        "Samuel Fagemo":[0]*32
    }


    #run the draft k times
    j=0
    k=1000   
    while(j<k):
        draft=rundraft() #runs draft and saves results in list
        #iterate through the draft results and update the overall results
        for selection in draft:
            try:
                location = draft.index(selection)
                players[selection][location] +=1
            except:
                pass
        j+=1
        
        #stupid progress tracker
        if(j==k//1 or j==k//2.5 or j==k//2 or j==k//(5/3) or j==k//1.25):
            print(round((j/k)*100,1)," % complete...",j," simulations out of ",k," completed")
        
        
    #output the results into a csv file   
    with open('SimResults.csv','w') as f:
        w = csv.writer(f)
        w.writerows(players.items())    
    
    #print(players)
     
#main and output
TimeStart = time.time()
main()
TimeEnd = time.time()
print('100% complete. The simulation took: ',TimeEnd-TimeStart, ' seconds to complete')
input('Press enter to close')

