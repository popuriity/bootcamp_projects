# homework 01
# replit : https://replit.com/@ThunpischaYodka/Batch06chatbotpizza?v=1
# chatbot (rule-based)
# ordering pizza

# greeting
print("Welcome to PuriPizza!")

#question 01: username
print("What's your name? : ")
user_name <- readLines("stdin", n=1)
print(paste("Hi", user_name))

# create vecter to collect order and amount
orders <- c()
amounts <- c()

# in case customers don't order anything.
order <- "None"
amount <- 0

order_con <- "1"
while (order_con == "1"){
  # question 02: order
  print("What do you want to order today?")
  print("1.Pizza  2.Snacks  3.Drinks")
  action <- readLines("stdin", n=1)
  
  if ( !(action %in% c("1","2","3")) ){
    # in case customer type other number (incorrectly)
    print("Please select what menu would you like to order.")
    order_con <- "1"
  } else if (action == "1"){    
    # question 03: pizza topping
    print("Please select pizza topping")
    print("1.Hawaiian  2.Meat Deluxe  3.Parma Ham")
    pizza <- readLines("stdin", n=1)
      if (pizza == "1"){
        #print("You choose Hawaiian.")
        order <- "Hawaiian Pizza"
      } else if (pizza == "2") {
        #print("You choose Meat Deluxe.")
        order <- "Meat Deluxe Pizza"
      } else if (pizza == "3") {
        #print("You choose Parma Ham.")
        order <- "Parma Ham Pizza"
      }  
    # question 03.1: amount of order
    print(paste("How many", order, "do you want?"))
    amount <- readLines("stdin", n=1)
  } else if (action == "2"){
    # question 04: snack
    print("Which snack would you like to order?")
    print("1.Nuggets  2.Frech Fries  3.Hash browns")
    snack <- readLines("stdin", n=1)
        if (snack == "1"){
        #print("You choose Nuggets.")
        order <- "Nuggets"
      } else if (snack == "2") {
        #print("You choose Frech Fries.")
        order <- "Frech Fries"
      } else if (snack == "3") {
        #print("You choose Hash browns.")
        order <- "Hash browns"
      }
    # question 04.1: amount of order
    print(paste("How many", order, "do you want?"))
    amount <- readLines("stdin", n=1)
  } else if (action == "3"){
    drink_con <- "1"
    while (drink_con == "1"){
      # question 05: water
      print("Which drink would you like to order?")
      print("1.Plain Water  2.Cola  3.Orange Juice")
      
      drink <- readLines("stdin", n=1)
      
      # Orange juice is out ofstock
      # ask if customer want to continue
      if (drink == "3") {
          print("We're sorry! Orange juice is out of stock.")
        # question 06: select other drinks
          print("Would you like to select other drinks instead?")
          print("1.Yes  0.No")
          drink_con <- readLines("stdin", n = 1)
        } else if (drink == "1"){
          order <- "Water"
          print(paste("How many", order, "do you want?"))
          amount <- readLines("stdin", n=1) # question 06.1: amount of order
          break
        } else if (drink == "2") {
          order <- "Cola"
          print(paste("How many", order, "do you want?"))
          amount <- readLines("stdin", n=1) # question 06.2: amount of order
          break
        }
    }
   # print(paste("How many", order, "do you want?"))
   # amount <- readLines("stdin", n=1) # question 06.1: amount of order
  }

  # question 07: ask if anything else?
  print("Do you want to order anything else ?")
  print("1.Yes,  0.No")
  order_con <- readLines("stdin", n = 1) 

  # collect order and amount in vector
  orders <- c(orders, order)
  amounts <- c(amounts, amount)
}
# create order dataframe
all_order <- data.frame("order" = orders, "amount" = amounts)

# question 08: payment method
# in case : customer wants to buy only orange juice, but it's out of stock...
if (all_order[1,"order"] != "None"){
    payment_check <- "0"
  while (payment_check == "0"){
    print("Please select payment method")
    print("1.Cash on delivery, 2.Credit Card, 3.Promptpay")
    payment <- readLines("stdin", n = 1)
      if (payment == "1"){
      payment_text <- "Cash on delivery"
      break
      } else if (payment == "2"){
      payment_text <- "Credit Card"
      break
      } else if (payment == "3"){
      payment_text <- "Promptpay"
      break
      }
    }
  print("Here's all of your order.")
  print(all_order)
  print(paste("Payment method:", payment_text))
  print("Thank you for your order.")
  print("Have a nice meal!")  
} else {
  print("Your cart is empty.")
  print(all_order)
  print("Thank you for visit us.")
}

