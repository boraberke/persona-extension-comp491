from selenium import webdriver
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.common.by import By
from selenium.webdriver.chrome.options import Options
import threading
import math
import time
#todo yüklenmeden yeni tab aç track this link gibi

driver_path = "chromedriver"
websites = ["http://www.python.org", 
            'https://www.bing.com/',
            'https://www.facebook.com/',
            'https://www.geeksforgeeks.org/',
            "https://reactjs.org/",
            'https://coens.io/',
            'https://www.koctas.com.tr',
            'https://www.boyner.com.tr'
            ]
def brows_bot(driver_path):
    cookies = []
    webBrowser = webdriver.Chrome(driver_path)
    webBrowser.get("http://www.python.org")
    cookies1  = webBrowser.get_cookies();  
    cookies.append(cookies1)
    return cookie

    # Lets open https://www.bing.com/ in the second tab
    webBrowser.execute_script("window.open('about:blank', 'secondtab');")
    webBrowser.switch_to.window("secondtab")
    webBrowser.get('https://www.bing.com/')
    webBrowser.get_cookies();  
    cookies2  = webBrowser.get_cookies();  
    cookies.append(cookies2)

    # Lets open https://www.facebook.com/ in the third tab
    webBrowser.execute_script("window.open('about:blank', 'thirdtab');")
    webBrowser.switch_to.window("thirdtab")
    webBrowser.get('https://www.facebook.com/')
    webBrowser.get_cookies();  
    cookies3  = webBrowser.get_cookies();  
    cookies.append(cookies3)

    webBrowser.switch_to.window("secondtab")
    webBrowser.get('https://www.geeksforgeeks.org/')
    webBrowser.get_cookies();  
    cookies4  = webBrowser.get_cookies();  
    cookies.append(cookies4)


def brows_bot2():
    webBrowser = webdriver.Chrome(driver_path)
    cookies = []
    webBrowser.get("https://reactjs.org/")
    webBrowser.get_cookies();  
    cookies1  = webBrowser.get_cookies();  
    cookies.append(cookies1)

    # Lets open https://www.bing.com/ in the second tab
    webBrowser.execute_script("window.open('about:blank', 'secondtab');")
    webBrowser.switch_to.window("secondtab")
    webBrowser.get('https://coens.io/')
    webBrowser.get_cookies();  
    cookies2  = webBrowser.get_cookies();  
    cookies.append(cookies2)

    # Lets open https://www.facebook.com/ in the third tab
    webBrowser.execute_script("window.open('about:blank', 'thirdtab');")
    webBrowser.switch_to.window("thirdtab")
    webBrowser.get('https://www.koctas.com.tr')
    webBrowser.get_cookies();  
    cookies3  = webBrowser.get_cookies();  
    cookies.append(cookies3)


    webBrowser.switch_to.window("secondtab")
    webBrowser.get('https://www.boyner.com.tr')
    webBrowser.get_cookies();  
    cookies4  = webBrowser.get_cookies();  
    cookies.append(cookies4)


def double_thread_multi_tab_v1():
    t1 = threading.Thread(target=brows_bot)
    t2 = threading.Thread(target=brows_bot2)
    # starting thread 1
    t1.start()
    # starting thread 2
    t2.start()

    # wait until thread 1 is completely executed
    t1.join()
    # wait until thread 2 is completely executed
    t2.join()

def single_thread_single_tab_v1(websites):
    cookies = []
    webBrowser = webdriver.Chrome(driver_path)
    for website in websites:
        webBrowser.get(website)
        cookie = webBrowser.get_cookies()
        cookies.append(cookie)

def single_thread_single_tab_headless_v2(websites):
    cookies = []
    chrome_options = Options()
    chrome_options.add_argument("--headless")      
    webBrowser = webdriver.Chrome(driver_path,options=chrome_options)
    for website in websites:
        webBrowser.get(website)
        cookie = webBrowser.get_cookies()
        cookies.append(cookie)
    print(cookies)


def single_thread_seperate_tab_v1(websites):
    cookies = []
    webBrowser = webdriver.Chrome(driver_path)
    for count,website in enumerate(websites):
        webBrowser.execute_script("window.open('about:blank', '{}');".format(str(count) + "tab"))
        webBrowser.switch_to.window(str(count) + "tab")
        webBrowser.get(website)
        cookie = webBrowser.get_cookies();  
        cookies.append(cookie)

def double_thread_single_tab_v1(websites):
    sub_websites1 = websites[0:math.ceil(len(websites)/2)]
    sub_websites2 = websites[math.ceil(len(websites)/2):-1] 
    t1 = threading.Thread(target=single_thread_single_tab_v1, args= (sub_websites1,))
    t2 = threading.Thread(target=single_thread_single_tab_v1, args= (sub_websites2,))
    # starting thread 1
    t1.start()
    # starting thread 2
    t2.start()

    # wait until thread 1 is completely executed
    t1.join()
    # wait until thread 2 is completely executed
    t2.join()


def double_thread_single_tab_headless_v2(websites):
    sub_websites1 = websites[0:math.ceil(len(websites)/2)]
    sub_websites2 = websites[math.ceil(len(websites)/2):-1] 
    t1 = threading.Thread(target=single_thread_single_tab_headless_v2, args= (sub_websites1,))
    t2 = threading.Thread(target=single_thread_single_tab_headless_v2, args= (sub_websites2,))
    # starting thread 1
    t1.start()
    # starting thread 2
    t2.start()

    # wait until thread 1 is completely executed
    t1.join()
    # wait until thread 2 is completely executed
    t2.join()








results = []
start = time.time()
double_thread_single_tab_v1(websites)
end = time.time()
results.append("Run time of double thread single tab v1: {}".format(end - start))

start = time.time()
single_thread_single_tab_v1(websites)
end = time.time()
results.append("Run time of single thread single tab v1: {}".format(end - start))

start = time.time()
single_thread_seperate_tab_v1(websites)
end = time.time()
results.append("Run time of single thread seperate tab v1: {}".format(end - start))

start = time.time()
double_thread_multi_tab_v1()
end = time.time()
results.append("Run time of double thread multi tab v1: {}".format(end - start))


start = time.time()
double_thread_single_tab_headless_v2(websites)
end = time.time()
results.append("Run time of double thread sinlge tab headless v2: {}".format(end - start))

for res in results:
    print(res)
