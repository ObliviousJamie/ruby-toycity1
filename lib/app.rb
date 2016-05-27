require 'json'
require 'date'
path = File.join(File.dirname(__FILE__), '../data/products.json')
file = File.read(path)
products_hash = JSON.parse(file)

# Print today's date
puts Date.today

puts "                     _            _       "
puts "                    | |          | |      "
puts " _ __  _ __ ___   __| |_   _  ___| |_ ___ "
puts "| '_ \\| '__/ _ \\ / _` | | | |/ __| __/ __|"
puts "| |_) | | | (_) | (_| | |_| | (__| |_\\__ \\"
puts "| .__/|_|  \\___/ \\__,_|\\__,_|\\___|\\__|___/"
puts "| |                                       "
puts "|_|                                       "


# For each product in the data set:
  # Print the name of the toy
  # Print the retail price of the toy
  # Calculate and print the total number of purchases
  # Calculate and print the total amount of sales
  # Calculate and print the average price the toy sold for
  # Calculate and print the average discount (% or $) based off the average sales price

  #Printing the items and prices
  products_hash["items"].each do |toy|
      full_price = toy["full-price"]
      puts "Product name: #{toy["title"]} "
      puts "Product price: $#{full_price} "

      #Variables set to 0 before loop
      sale_total = 0
      purchases = 0

      #Loop to add up sales and purchases
      toy["purchases"].each do |sale|
          purchases = purchases + 1
          sale_total = sale_total + sale["price"] 
      end

      #Finding average price
      average_price = sale_total/purchases
      #Finding average discount
      full_price = full_price.to_f  #Must be float to divide by another float 
      average_discount = (average_price / full_price) * 10
     
      puts "Total purchases #{purchases} "
      puts "Total sales $#{sale_total} "
      puts "Average price $#{average_price} "
      puts "Average discount: #{average_discount.round(2)}% \n "  
  end



	puts " _                         _     "
	puts "| |                       | |    "
	puts "| |__  _ __ __ _ _ __   __| |___ "
	puts "| '_ \\| '__/ _` | '_ \\ / _` / __|"
	puts "| |_) | | | (_| | | | | (_| \\__ \\"
	puts "|_.__/|_|  \\__,_|_| |_|\\__,_|___/"
	puts

# For each brand in the data set:
  # Print the name of the brand
  # Count and print the number of the brand's toys we stock
  # Calculate and print the average price of the brand's toys
  # Calculate and print the total revenue of all the brand's toy sales combined

        brands_hash = Hash.new
        #Loop to get all values for each brand
        products_hash["items"].each do |brand|
            brand_name = brand["brand"]
            brand_stock = brand["stock"]
            brand_price = brand["full-price"] 
            brand_revenue = 0
        
            #Loop to add value of all purchases
            brand["purchases"].each do |purchase|
                brand_revenue = brand_revenue + purchase["price"]
            end

            

            #Unless already added to hash add it otherwise update it
            unless brands_hash.has_key?(brand_name)
                id = 1
                brands_hash[brand_name] = {
                    product_id: id.to_i,
                    toy_count: brand_stock.to_i, 
                    avg_price: brand_price.to_f,
                    revenue: brand_revenue.to_f
                }
            else
                #Updating hash
                current_brand = brands_hash[brand_name]

                current_brand[:product_id] += 1
                current_brand[:toy_count] += brand_stock.to_i
                current_brand[:avg_price] += brand_price.to_f
                current_brand[:revenue] += brand_revenue.to_f
            end
        end
        #Printing variables
        brands_hash.each do |brand, rest| 
            puts "Brand: #{brand} "
            brand_no = rest[:product_id].to_f
            puts "Toy Stock: #{rest[:toy_count].to_i }"
            puts "Average Brand Price: $#{(rest[:avg_price] / brand_no).round(2)} "
            puts "Revenue: $#{rest[:revenue].round(2)} \n \n"
        end
