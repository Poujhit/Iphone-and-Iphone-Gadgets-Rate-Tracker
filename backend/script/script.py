import sys
import os
import json
from bs4 import BeautifulSoup
# from selenium import webdriver
import re
import requests

# chrome_options = webdriver.ChromeOptions()
# chrome_options.binary_location = os.environ.get("GOOGLE_CHROME_BIN")
# chrome_options.add_argument("--headless")
# chrome_options.add_argument("--disable-dev-shm-usage")
# chrome_options.add_argument("--no-sandbox")

# driver = webdriver.Chrome(executable_path=os.environ.get("CHROMEDRIVER_PATH"),chrome_options=chrome_options)

# remove the top 6 lines when doing local testing and add the below line. for deployment keep this option.
# driver = webdriver.Chrome(r"D:\flutter_app_folder\iphone_rates_tracker\backend\script\chromedriver.exe", port=9515)
# driver.get('https://www.flipkart.com/search?q=iphone')
response = requests.get('https://www.flipkart.com/search?q=iphone')
soup = BeautifulSoup(response.text, 'html.parser')
url = '"https://www.flipkart.com'
# i = 0

data = {}
alldata = []

for item in soup.select('[data-id]'):
    eachitem = {}
    # i = i+1
    # print(i)
    # print('----------------------------------------')
    # print(item.select('a img')[0]['alt'])
    eachitem.update({"name":str(item.select('a img')[0]['alt'])})
    # print(item.select('a')[0]['href'])
    eachitem.update({"product-link":str('www.flipkart.com'+str(item.select('a')[0]['href']))})

    if(len(item.select('[id*=productRating]')) != 0):
        # print(item.select('[id*=productRating]')[0].get_text().strip())
        eachitem.update({"rating":str(item.select('[id*=productRating]')[0].get_text().strip())})
    else:
        # print('rating null-')
        eachitem.update({"rating":"-"})
    prices = item.find_all(text=re.compile('₹'))
    # print(prices[0])
    eachitem.update({"price":str(prices[0])})

    discounts = item.find_all(text=re.compile('off'))
    if len(discounts) != 0:
        # print(discounts[0])
        eachitem.update({"discount":str(discounts[0])})
    else:
        eachitem.update({"discount": "-"})
    alldata.append(eachitem)

data.update({"alldata":alldata})
json_data = json.dumps(data,sort_keys=True)

# driver.close()
print(json_data)
sys.stdout.flush()
