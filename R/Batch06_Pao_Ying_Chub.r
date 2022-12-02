# Homework 02
# replit : https://replit.com/@ThunpischaYodka/Batch6PaoYingChub?v=1
# Pao Ying Chub
# user play unlimited times
# sum win, loss, tie

# create df contains case and result
game <- data.frame(
  bot = c(rep("rock",3),
          rep("paper",3),
          rep("scissors",3) ),
  player = c( rep(c("rock", "paper", "scissors"), 3) ),
  result_bot = c("tie", "loss", "win", "win", "tie", "loss", "loss", "win", "tie"),
  result_player = c("tie", "win", "loss", "loss", "tie", "win", "win", "loss", "tie")
)


weapon <- c("rock", "paper", "scissors") # weapon user can choose
results <- c() # store result

print("Welcome to Rock Paper Scissors!")

play <- ""
# if player doesn't select 0 or 1, then ask again
while( !(play %in% c("0", "1")) ){
    print("Are you ready? 1.Yes  0.No")
    play <- readLines('stdin', n = 1) 
  }

if (play == "0"){
  # player is not ready.
  print("See you later!")
} else if (play == "1"){
    
  while(play == "1"){
      
    bot <- sample(weapon, 1, replace = T)
    print("Select number: 1.rock  2.paper  3.scissors")
    player <- as.numeric( readLines('stdin', n = 1) )

    # find match case result in data frame
    result <- game[game$bot == bot & game$player == weapon[player], 'result_player']
      
    print(paste("bot:", bot))
    print(paste("you:", weapon[player]))
    print(paste("result:", result))
    print("--------------------------------")
    results <- c(results, result)
    
    # continue to play?
    print("Do you want to continue?")
    print("1.Yes  0.No")
    play <- readLines('stdin', n = 1) 
    while( !(play %in% c("0", "1")) ){
        print("Do you want to continue? 1.Yes  0.No")
        play <- readLines('stdin', n = 1)  # if player doesn't select 0 or 1, then ask again
      }
    } 
    # if stop playing, print results.
    table(results)
}

